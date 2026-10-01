import Foundation
import CryptoKit

struct RuntimeManifest: Codable, Identifiable {
    let id: String
    let name: String
    let version: String
    let engine: String
    let platform: String
    let ruby: String?
    let rgss: String?
    let size: Int64
    let sha256: String
    let url: URL
    let minCoreVersion: String
}

struct RuntimeIndex: Codable {
    let schema: Int
    let generatedAt: Date
    let runtimes: [RuntimeManifest]
}

enum RuntimeError: Error {
    case unavailable, hashMismatch, invalidPackage, incompatibleRuntime
}

@MainActor
final class RuntimeStore: ObservableObject {
    @Published private(set) var installed: [RuntimeManifest] = []
    private let fm = FileManager.default

    var root: URL {
        fm.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("RPGEngine/Runtimes", isDirectory: true)
    }

    func prepare() throws {
        try fm.createDirectory(at: root, withIntermediateDirectories: true)
        try refresh()
    }

    func refresh() throws {
        guard fm.fileExists(atPath: root.path) else { installed = []; return }
        installed = try fm.contentsOfDirectory(at: root, includingPropertiesForKeys: nil)
            .compactMap { dir in
                let m = dir.appendingPathComponent("runtime.json")
                guard fm.fileExists(atPath: m.path) else { return nil }
                return try JSONDecoder.rpgEngine.decode(RuntimeManifest.self, from: Data(contentsOf: m))
            }
    }

    func install(package: URL, expected: RuntimeManifest) throws {
        let hash = try SHA256.file(package)
        guard hash.caseInsensitiveCompare(expected.sha256) == .orderedSame else {
            throw RuntimeError.hashMismatch
        }
        // v0.5.1 build target intentionally verifies the package before install.
        // Archive extraction remains an explicit integration point for v0.6.
        throw RuntimeError.unavailable
    }
}

@MainActor
final class RuntimeManager: ObservableObject {
    let store = RuntimeStore()
    @Published private(set) var index: RuntimeIndex?

    func bootstrap(indexURL: URL) async throws {
        try store.prepare()
        let (data, response) = try await URLSession.shared.data(from: indexURL)
        guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
            throw RuntimeError.unavailable
        }
        index = try JSONDecoder.rpgEngine.decode(RuntimeIndex.self, from: data)
    }

    func install(_ runtime: RuntimeManifest) async throws {
        let (temp, response) = try await URLSession.shared.download(from: runtime.url)
        guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
            throw RuntimeError.unavailable
        }
        try store.install(package: temp, expected: runtime)
    }
}

enum SHA256 {
    static func file(_ url: URL) throws -> String {
        let h = try FileHandle(forReadingFrom: url)
        defer { try? h.close() }
        var hasher = CryptoKit.SHA256()
        while true {
            let d = try h.read(upToCount: 1024 * 1024) ?? Data()
            if d.isEmpty { break }
            hasher.update(data: d)
        }
        return hasher.finalize().map { String(format: "%02x", $0) }.joined()
    }
}

extension JSONDecoder {
    static var rpgEngine: JSONDecoder {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601
        return d
    }
}
