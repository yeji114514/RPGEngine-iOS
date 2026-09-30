import Foundation

final class VXAceProvider: GameProvider {
    let identifier = "vxace"
    let displayName = "RPG Maker VX Ace"

    func canHandle(_ game: GameDetectionResult) -> Bool {
        game.type == .vxAce
    }

    func prepare(game: GameDetectionResult, runtime: RuntimeManifest) throws {
        guard runtime.engine == identifier,
              runtime.platform == "ios-arm64" else {
            throw RuntimeError.incompatibleRuntime
        }

        let scripts = game.projectURL.appendingPathComponent("Data/Scripts.rvdata2")
        guard FileManager.default.fileExists(atPath: scripts.path) else {
            throw RuntimeError.invalidPackage
        }
    }

    func launch(game: GameDetectionResult, runtime: RuntimeManifest) throws {
        try prepare(game: game, runtime: runtime)
        // v0.7: EngineHost -> Ruby VM -> RGSS3 -> Scene_Map -> Metal.
    }
}
