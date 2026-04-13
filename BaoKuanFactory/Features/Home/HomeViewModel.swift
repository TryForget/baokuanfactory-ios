import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var topic: String = ""
    @Published var selectedStyle: VideoStyle = .emotion
    @Published var selectedDuration: VideoDuration = .thirty
    @Published var recentHistory: [HistoryItem] = []
    @Published var generatedResult: ScriptResult?
    @Published var showResult = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var isLoading = false

    let styles = VideoStyle.allCases
    let quickTemplates: [String] = ["情绪共鸣", "励志逆袭", "老板创业", "女性成长", "国漫燃向"]

    var isGenerateDisabled: Bool {
        isLoading || topic.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private let generator: ScriptGeneratorServiceProtocol
    private let historyStorage = HistoryStorageService()

    init(generator: ScriptGeneratorServiceProtocol = ScriptGeneratorFactory.make()) {
        self.generator = generator
        self.recentHistory = historyStorage.load()
    }

    func applyQuickTemplate(_ text: String) {
        topic = text
    }

    func generate() {
        let cleanTopic = topic.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanTopic.isEmpty else {
            presentError("先输入一个主题")
            return
        }

        guard !isLoading else { return }

        isLoading = true
        showResult = false

        Task {
            do {
                let result = try await generator.generate(topic: cleanTopic, style: selectedStyle, duration: selectedDuration)
                generatedResult = result
                let historyItem = HistoryItem(
                    id: UUID(),
                    title: result.titles.first ?? cleanTopic,
                    style: selectedStyle,
                    duration: selectedDuration,
                    result: result,
                    createdAt: Date()
                )
                historyStorage.append(historyItem)
                recentHistory = historyStorage.load()
                showResult = true
            } catch {
                presentError(error.localizedDescription.isEmpty ? "生成失败，请稍后再试" : error.localizedDescription)
            }

            isLoading = false
        }
    }

    private func presentError(_ message: String) {
        alertMessage = message
        showAlert = true
    }
}
