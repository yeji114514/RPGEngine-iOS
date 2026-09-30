import Foundation

final class ProviderRegistry {
    let providers: [GameProvider] = [VXAceProvider()]

    func provider(for game: GameDetectionResult) -> GameProvider? {
        providers.first { $0.canHandle(game) }
    }
}
