import Foundation

enum RuntimeResolver {
    static func resolve(game: GameDetectionResult, installed: [RuntimeManifest]) -> RuntimeManifest? {
        installed
            .filter { $0.engine == game.type.rawValue && $0.platform == "ios-arm64" }
            .sorted { $0.version.compare($1.version, options: .numeric) == .orderedDescending }
            .first
    }
}
