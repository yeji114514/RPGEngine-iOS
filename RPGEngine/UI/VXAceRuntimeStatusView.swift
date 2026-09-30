import SwiftUI

struct VXAceRuntimeStatusView: View {
    let game: GameProject
    let runtime: RuntimeManifest?

    var body: some View {
        let status = RubyRuntimeLocator.status(runtime: runtime)

        List {
            Section("Game") {
                LabeledContent("Type", value: game.isVXAce ? "RPG Maker VX Ace" : "Unknown")
                LabeledContent("Scripts", value: ScriptsRVData2.exists(in: game.url) ? "Found" : "Missing")
                LabeledContent("Map001", value: VXAceMap.locate(id: 1, in: game.url) == nil ? "Missing" : "Found")
            }

            Section("Runtime") {
                LabeledContent("Ruby", value: status.version)
                LabeledContent("RGSS", value: status.rgssVersion)
                LabeledContent("Arch", value: status.architecture)
                LabeledContent("Status", value: status.available ? "Installed" : "Required")
            }
        }
        .navigationTitle("VX Ace Runtime")
    }
}
