import Foundation

struct GenerateScriptResponse: Decodable {
    let titles: [String]
    let script: String
    let storyboards: [String]
    let coverTexts: [String]
    let tags: [String]
    let remainingQuota: Int?
    let isPremium: Bool?
    let requestId: String?
    let generationSource: String?

    func toDomainModel() throws -> ScriptResult {
        let normalizedTitles = titles.filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
        let normalizedScript = script.trimmingCharacters(in: .whitespacesAndNewlines)
        let normalizedStoryboards = storyboards.filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
        let normalizedCoverTexts = coverTexts.filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
        let normalizedTags = tags.filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }

        guard !normalizedTitles.isEmpty,
              !normalizedScript.isEmpty,
              !normalizedStoryboards.isEmpty else {
            throw APIError.emptyResponse
        }

        return ScriptResult(
            titles: normalizedTitles,
            script: normalizedScript,
            storyboards: normalizedStoryboards,
            coverTexts: normalizedCoverTexts,
            tags: normalizedTags,
            remainingQuota: remainingQuota,
            isPremium: isPremium,
            requestId: requestId?.trimmingCharacters(in: .whitespacesAndNewlines),
            generationSource: generationSource?.trimmingCharacters(in: .whitespacesAndNewlines)
        )
    }
}
