import Foundation

struct ScriptResult: Codable, Hashable {
    let titles: [String]
    let script: String
    let storyboards: [String]
    let coverTexts: [String]
    let tags: [String]
    let remainingQuota: Int?
    let isPremium: Bool?
    let requestId: String?
    let generationSource: String?
}
