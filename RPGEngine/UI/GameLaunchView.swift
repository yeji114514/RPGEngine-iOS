import SwiftUI

struct GameLaunchView: View {
    let game: GameDetectionResult
    @State private var status = "Checking runtime…"

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "gamecontroller.fill").font(.system(size: 56))
            Text(game.name).font(.title2.bold())
            Text("RPG Maker VX Ace").foregroundStyle(.secondary)
            Text(status)
            ForEach(game.evidence, id: \.self) {
                Label($0, systemImage: "checkmark.circle")
            }
        }
        .padding()
        .task { status = "VX Ace project detected; waiting for compatible Runtime" }
    }
}
