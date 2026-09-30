import SwiftUI
struct VXAceLaunchView: View {
 let project: GameProject
 @State private var status: String = "检查 Runtime…"
 var body: some View {
  VStack(spacing: 16) {
   Text(project.name).font(.title2)
   Text(status).font(.caption)
   Button("启动 VX Ace") {
    let result = VXAceLaunch.prepare(project)
    status = result.ready ? "启动链已准备：Scene_Map / Map001" : (result.reason ?? "无法启动")
   }
   .buttonStyle(.borderedProminent)
  }.padding().navigationTitle("VX Ace")
 }
}