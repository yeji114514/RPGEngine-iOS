import Foundation

struct VXAceRuntimeSession {
    enum State: Equatable {
        case idle
        case preparing
        case waitingForRuntime
        case loadingScripts
        case loadingMap
        case ready
        case failed(String)
    }

    private(set) var state: State = .idle

    mutating func prepare(game: GameProject, runtime: RuntimeManifest?) {
        state = .preparing

        guard game.isVXAce else {
            state = .failed("不是 VX Ace 项目")
            return
        }

        guard runtime != nil else {
            state = .waitingForRuntime
            return
        }

        guard ScriptsRVData2.exists(in: game.url) else {
            state = .failed("缺少 Data/Scripts.rvdata2")
            return
        }

        guard VXAceMap.locate(id: 1, in: game.url) != nil else {
            state = .failed("缺少 Data/Map001.rvdata2")
            return
        }

        state = .ready
    }
}
