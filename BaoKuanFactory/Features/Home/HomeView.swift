import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var membershipService: MembershipService
    @EnvironmentObject private var appSettings: AppSettings
    @StateObject private var viewModel = HomeViewModel()

    private let trendingExamples: [(title: String, subtitle: String)] = [
        ("老板不是风光，是没人替你扛", "老板创业 · 高压共鸣"),
        ("女人真正的清醒，是不再等别人懂你", "女性成长 · 情绪表达"),
        ("你以为是绝路，其实是命在逼你变强", "国漫燃向 · 热血逆袭")
    ]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 18) {
                heroSection
                trendingSection

                TopicInputCard(topic: $viewModel.topic)

                VStack(alignment: .leading, spacing: 10) {
                    Text("热门切题方向")
                        .font(AppTypography.section)
                        .foregroundStyle(AppColors.textPrimary)
                    QuickTemplateChips(items: viewModel.quickTemplates, onTap: viewModel.applyQuickTemplate)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                StyleSelectorView(selectedStyle: $viewModel.selectedStyle, styles: viewModel.styles)
                DurationSelectorView(selectedDuration: $viewModel.selectedDuration)

                PrimaryButton(
                    title: viewModel.isLoading ? "正在生成高转化文案..." : "立即生成爆款文案",
                    isDisabled: viewModel.isGenerateDisabled,
                    action: viewModel.generate
                )

                if viewModel.isLoading {
                    ProgressView("正在为你打磨标题、口播稿和分镜...")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(AppColors.textSecondary)
                }

                RecentHistorySection(items: Array(viewModel.recentHistory.prefix(3)))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("爆款工厂")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $viewModel.showResult) {
            ResultView(result: viewModel.generatedResult)
        }
        .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
            Button("知道了", role: .cancel) {}
        }
        .onAppear {
            viewModel.bindServices(
                membershipService: membershipService,
                appSettings: appSettings
            )
        }
    }

    private var heroSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("一键生成")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.9))
                    Text("爆款短视频文案")
                        .font(.system(size: 30, weight: .heavy))
                        .foregroundStyle(.white)
                }
                Spacer()
                Text(membershipService.currentPlan.title)
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(AppColors.textPrimary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .clipShape(Capsule())
            }

            Text("标题、口播稿、分镜、封面文案一次出齐，直接拿去拍。")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.86))

            HStack(spacing: 10) {
                heroTag("高转化标题")
                heroTag("情绪钩子")
                heroTag("直接可拍")
            }

            HStack(spacing: 12) {
                metricCard(
                    title: membershipService.isPremium ? "当前状态" : "今日剩余",
                    value: membershipService.isPremium ? "无限生成" : "\(membershipService.remainingFreeGenerations) 次"
                )
                metricCard(
                    title: "生成能力",
                    value: "标题 + 文案 + 分镜"
                )
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColors.heroGradient)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .shadow(color: AppColors.primary.opacity(0.24), radius: 24, x: 0, y: 14)
    }

    private var trendingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("平台热感案例")
                    .font(AppTypography.section)
                    .foregroundStyle(AppColors.textPrimary)
                Spacer()
                Text("今天适合做这些")
                    .font(.caption)
                    .foregroundStyle(AppColors.textSecondary)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Array(trendingExamples.enumerated()), id: \.offset) { index, item in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(index == 0 ? "爆款热度高" : "可直接套用")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(.white.opacity(0.84))
                            Text(item.title)
                                .font(.headline.weight(.heavy))
                                .foregroundStyle(.white)
                                .lineLimit(3)
                            Text(item.subtitle)
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.8))
                        }
                        .padding(16)
                        .frame(width: 240, alignment: .leading)
                        .background(index == 0 ? AnyShapeStyle(AppColors.heroGradient) : AnyShapeStyle(LinearGradient(colors: [AppColors.accent, AppColors.primary], startPoint: .topLeading, endPoint: .bottomTrailing)))
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    }
                }
                .padding(.vertical, 2)
            }
        }
    }

    private func heroTag(_ text: String) -> some View {
        Text(text)
            .font(.caption.weight(.semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.white.opacity(0.14))
            .clipShape(Capsule())
    }

    private func metricCard(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundStyle(AppColors.textSecondary)
            Text(value)
                .font(.subheadline.weight(.bold))
                .foregroundStyle(AppColors.textPrimary)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}
