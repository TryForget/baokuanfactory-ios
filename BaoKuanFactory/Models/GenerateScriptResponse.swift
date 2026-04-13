import Foundation

struct GenerateScriptResponse: Decodable {
    let titles: [String]
    let script: String
    let storyboards: [String]
    let coverTexts: [String]
    let tags: [String]

    func toDomainModel() -> ScriptResult {
        ScriptResult(
            titles: titles,
            script: script,
            storyboards: storyboards,
            coverTexts: coverTexts,
            tags: tags
        )
    }
}
