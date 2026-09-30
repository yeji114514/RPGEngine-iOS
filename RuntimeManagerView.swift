import SwiftUI

struct RuntimeManagerView: View {
    let indexURL: URL
    @StateObject private var manager = RuntimeManager()

    var body: some View {
        List {
            if let index = manager.index {
                ForEach(index.runtimes) { runtime in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(runtime.name)
                            Text("\(runtime.version) · \(runtime.platform)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        if manager.store.installed.contains(where: {
                            $0.id == runtime.id && $0.version == runtime.version
                        }) {
                            Text("已安装")
                                .foregroundStyle(.secondary)
                        } else {
                            Button("下载") {
                                Task { try? await manager.install(runtime) }
                            }
                        }
                    }
                }
            } else {
                ProgressView("读取 Runtime 索引…")
            }
        }
        .navigationTitle("Runtime")
        .task { try? await manager.bootstrap(indexURL: indexURL) }
    }
}
