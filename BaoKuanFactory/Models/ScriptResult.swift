import Foundation

struct ScriptResult: Codable, Hashable {
    let titles: [String]
    let script: String
    let storyboards: [String]
    let coverTexts: [String]
    let tags: [String]
}
