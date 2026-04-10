import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                TopicInputCard(topic: $viewModel.topic)

                QuickTemplateChips(items: viewModel.quickTemplates, onTap: viewModel.applyQuickTemplate)

                StyleSelectorView(selectedStyle: $viewModel.selectedStyle, styles: viewModel.styles)

                DurationSelectorView(selectedDuration: $viewModel.selectedDuration)

                PrimaryButton(title: "立即生成", action: viewModel.generate)

                RecentHistorySection(items: Array(viewModel.recentHistory.prefix(3)))
            }
            .padding()
        }
        .navigationTitle("爆款工厂")
        .navigationDestination(isPresented: $viewModel.showResult) {
            ResultView(result: viewModel.generatedResult)
        }
        .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
            Button("知道了", role: .cancel) {}
        }
    }
}
