import Foundation

struct RubyRuntimeStatus {
    let version: String
    let architecture: String
    let rgssVersion: String
    let available: Bool
}

enum RubyRuntimeLocator {
    static func status(runtime: RuntimeManifest?) -> RubyRuntimeStatus {
        RubyRuntimeStatus(
            version: runtime?.rubyVersion ?? "1.9.x",
            architecture: runtime?.platform ?? "ios-arm64",
            rgssVersion: runtime?.rgssVersion ?? "3",
            available: runtime != nil
        )
    }
}
