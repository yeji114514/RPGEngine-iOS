import Foundation

struct VXAceLaunchResult {
    let project: GameProject
    let mapID: Int
    let ready: Bool
    let reason: String?
}

enum VXAceLaunch {
    static func prepare(_ project: GameProject) -> VXAceLaunchResult {
        guard project.isVXAce else {
            return .init(project: project, mapID: 1, ready: false, reason: "不是 VX Ace 项目")
        }
        let scripts = ScriptsRVData2.exists(in: project.url)
        let map = VXAceMap.locate(id: 1, in: project.url) != nil
        guard scripts, map else {
            return .init(project: project, mapID: 1, ready: false, reason: "缺少 Scripts.rvdata2 或 Map001.rvdata2")
        }
        return .init(project: project, mapID: 1, ready: true, reason: nil)
    }
}