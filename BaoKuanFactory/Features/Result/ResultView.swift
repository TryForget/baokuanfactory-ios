import SwiftUI

struct ResultView: View {
    let result: ScriptResult?
    @State private var showCopiedToast = false

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                if let result {
                    resultHero(result)

                    if result.remainingQuota != nil || result.isPremium != nil || result.requestId != nil {
                        SectionCard(title: "本次生成状态") {
                            VStack(alignment: .leading, spacing: 8) {
                                if let source = result.generationSource, !source.isEmpty {
                                    Text(source == "llm" ? "本次结果来源：真实大模型生成" : "本次结果来源：系统兜底文案")
                                        .font(.subheadline.weight(.semibold))
                                }
                                if let isPremium = result.isPremium {
                                    Text(isPremium ? "当前账号状态：会员" : "当前账号状态：免费")
                                }
                                if let remainingQuota = result.remainingQuota {
                                    Text("服务端剩余次数：\(remainingQuota)")
                                }
                                if let requestId = result.requestId, !requestId.isEmpty {
                                    Text("请求 ID：\(requestId)")
                                        .font(AppTypography.caption)
                                        .foregroundStyle(AppColors.textSecondary)
                                }
                            }
                        }
                    }

                    TitleListCard(titles: result.titles)
                    ScriptCard(script: result.script)
                    StoryboardCard(items: result.storyboards)
                    CoverTextCard(items: result.coverTexts)
                    TagsCard(tags: result.tags)
                } else {
                    EmptyStateView(text: "暂无结果")
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("生成结果")
        .navigationBarTitleDisplayMode(.inline)
        .overlay(alignment: .bottom) {
            if showCopiedToast {
                Text("已复制到剪贴板")
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(.black.opacity(0.78))
                    .clipShape(Capsule())
                    .padding(.bottom, 24)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: showCopiedToast)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if let result {
                    Button("全部复制") {
                        var parts: [String] = []

                        if let source = result.generationSource, !source.isEmpty {
                            parts.append("结果来源: \(source)")
                        }
                        if let isPremium = result.isPremium {
                            parts.append("账号状态: \(isPremium ? "会员" : "免费")")
                        }
                        if let remainingQuota = result.remainingQuota {
                            parts.append("剩余次数: \(remainingQuota)")
                        }
                        if let requestId = result.requestId, !requestId.isEmpty {
                            parts.append("请求ID: \(requestId)")
                        }
                        if !parts.isEmpty {
                            parts.append("")
                        }

                        let merged = (parts + ["推荐标题:"] + result.titles + ["", "视频文案:", result.script, "", "分镜脚本:"] + result.storyboards + ["", "封面文案:"] + result.coverTexts + ["", "标签:"] + result.tags).joined(separator: "\n")
                        ClipboardService.copy(merged)
                        showCopiedToast = true

                        Task {
                            try? await Task.sleep(for: .seconds(1.6))
                            showCopiedToast = false
                        }
                    }
                }
            }
        }
    }

    private func resultHero(_ result: ScriptResult) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("这条内容可以直接拍")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.white.opacity(0.88))

            Text(result.titles.first ?? "生成完成")
                .font(.system(size: 28, weight: .heavy))
                .foregroundStyle(.white)

            Text("标题、口播稿、分镜和封面文案都帮你排好了，直接复制就能进入拍摄或发布流程。")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.82))
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColors.heroGradient)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .shadow(color: AppColors.primary.opacity(0.24), radius: 24, x: 0, y: 14)
    }
}
