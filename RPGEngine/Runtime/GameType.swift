import Foundation

enum GameType: String, Codable {
    case vxAce = "vxace"
    case unknown
}

struct GameDetectionResult: Identifiable {
    let id = UUID()
    let type: GameType
    let confidence: Int
    let projectURL: URL
    let name: String
    let evidence: [String]
}
