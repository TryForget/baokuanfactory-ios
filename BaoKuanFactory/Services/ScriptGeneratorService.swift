import Foundation

protocol ScriptGeneratorServiceProtocol {
    func generate(topic: String, style: VideoStyle, duration: VideoDuration) async throws -> ScriptResult
}

final class MockScriptGeneratorService: ScriptGeneratorServiceProtocol {
    func generate(topic: String, style: VideoStyle, duration: VideoDuration) async throws -> ScriptResult {
        ScriptResult(
            titles: [
                "关于\(topic)，这条内容建议你直接发",
                "\(topic)：一个更容易起流量的表达方式",
                "不会写\(topic)视频？这版可以直接用"
            ],
            script: "这是一个关于\(topic)的\(style.displayName)文案示例，时长为\(duration.displayName)。这里先放 mock 数据，后续再接真实生成接口。",
            storyboards: [
                "0-3秒：强钩子开头",
                "3-10秒：抛出冲突或情绪",
                "10-20秒：展开主体观点",
                "20-30秒：结尾金句收束"
            ],
            coverTexts: [
                "这条关于\(topic)的内容可以直接发",
                "真正拉流量的不是努力，是表达方式"
            ],
            tags: ["#短视频", "#文案", "#\(topic)"]
        )
    }
}

final class RemoteScriptGeneratorService: ScriptGeneratorServiceProtocol {
    private let apiClient: APIClient

    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }

    func generate(topic: String, style: VideoStyle, duration: VideoDuration) async throws -> ScriptResult {
        try await apiClient.generateScript(topic: topic, style: style, duration: duration)
    }
}

enum ScriptGeneratorFactory {
    static func make(environment: AppEnvironment = .current) -> ScriptGeneratorServiceProtocol {
        environment.usesMockGenerator ? MockScriptGeneratorService() : RemoteScriptGeneratorService()
    }
}
