import SwiftUI
import UniformTypeIdentifiers

struct GameLibraryView: View {
    @StateObject private var library = GameLibrary()
    @State private var importer = false

    var body: some View {
        NavigationStack {
            List(library.games) { game in
                NavigationLink {
                    GameLaunchView(game: game)
                } label: {
                    VStack(alignment: .leading) {
                        Text(game.name).font(.headline)
                        Text("RPG Maker VX Ace · \(game.confidence)%")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Games")
            .toolbar {
                Button { importer = true } label: {
                    Image(systemName: "plus")
                }
            }
            .fileImporter(isPresented: $importer,
                          allowedContentTypes: [.folder],
                          allowsMultipleSelection: false) { result in
                guard case .success(let urls) = result, let url = urls.first else { return }
                try? library.importGame(from: url)
            }
            .task { try? library.prepare() }
        }
    }
}
