import Foundation

protocol GameProvider {
    var identifier: String { get }
    var displayName: String { get }

    func canHandle(_ game: GameDetectionResult) -> Bool
    func prepare(game: GameDetectionResult, runtime: RuntimeManifest) throws
    func launch(game: GameDetectionResult, runtime: RuntimeManifest) throws
}
