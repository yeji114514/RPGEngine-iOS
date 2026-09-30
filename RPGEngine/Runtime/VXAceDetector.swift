import Foundation

enum VXAceDetector {
    static func detect(at url: URL) -> GameDetectionResult? {
        let fm = FileManager.default
        let data = url.appendingPathComponent("Data")
        var score = 0
        var evidence: [String] = []

        for (relative, points) in [
            ("Game.ini", 25),
            ("Data/Scripts.rvdata2", 35),
            ("Data/MapInfos.rvdata2", 25),
            ("Data/Map001.rvdata2", 15)
        ] {
            if fm.fileExists(atPath: url.appendingPathComponent(relative).path) {
                score += points
                evidence.append(relative)
            }
        }

        guard score >= 60 else { return nil }

        return GameDetectionResult(
            type: .vxAce,
            confidence: min(score, 100),
            projectURL: url,
            name: url.lastPathComponent,
            evidence: evidence
        )
    }

    static func scan(directory: URL) -> [GameDetectionResult] {
        guard let urls = try? FileManager.default.contentsOfDirectory(
            at: directory,
            includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsHiddenFiles]
        ) else { return [] }

        return urls.compactMap { url in
            guard (try? url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) == true else { return nil }
            return detect(at: url)
        }
    }
}
