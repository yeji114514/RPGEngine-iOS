import Foundation

struct RuntimeManifest: Codable, Identifiable {
    let id: String
    let name: String
    let version: String
    let engine: String
    let platform: String
    let rubyVersion: String?
    let rgssVersion: String?
    let minCoreVersion: String

    enum CodingKeys: String, CodingKey {
        case id, name, version, engine, platform
        case rubyVersion = "ruby"
        case rgssVersion = "rgss"
        case minCoreVersion
    }
}

enum RuntimeError: Error {
    case incompatibleRuntime
    case invalidPackage
    case unavailable
}
