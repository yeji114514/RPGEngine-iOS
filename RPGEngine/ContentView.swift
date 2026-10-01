import SwiftUI

struct ContentView: View {
    @State private var showRuntime = false

    var body: some View {
        List {
            Section("RPGEngine") {
                Text("VX Ace Runtime Host")
                Text("iOS 16 / Metal")
                    .foregroundStyle(.secondary)
            }

            Section("Runtime") {
                NavigationLink("Runtime Manager") {
                    RuntimeManagerView(indexURL: URL(string: "https://example.invalid/runtimes/index.json")!)
                }
                NavigationLink("VX Ace Diagnostics") {
                    Text("Select a game project to inspect Game.ini, Scripts.rvdata2 and Map001.rvdata2.")
                        .padding()
                }
            }
        }
        .navigationTitle("RPGEngine")
    }
}
