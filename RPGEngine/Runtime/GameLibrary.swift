import Foundation

@MainActor
final class GameLibrary: ObservableObject {
    @Published private(set) var games: [GameDetectionResult] = []

    private let fm = FileManager.default

    var rootURL: URL {
        fm.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("RPGEngine/Games", isDirectory: true)
    }

    func prepare() throws {
        try fm.createDirectory(at: rootURL, withIntermediateDirectories: true)
        try scan()
    }

    func scan() throws {
        games = VXAceDetector.scan(directory: rootURL)
    }

    func importGame(from source: URL) throws {
        let scoped = source.startAccessingSecurityScopedResource()
        defer { if scoped { source.stopAccessingSecurityScopedResource() } }

        let name = source.lastPathComponent
        let destination = rootURL.appendingPathComponent(name, isDirectory: true)

        if fm.fileExists(atPath: destination.path) {
            try fm.removeItem(at: destination)
        }
        try fm.copyItem(at: source, to: destination)
        try scan()
    }
}
