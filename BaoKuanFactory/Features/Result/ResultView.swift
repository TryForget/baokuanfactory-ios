import SwiftUI

struct ResultView: View {
    let result: ScriptResult?

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let result {
                    TitleListCard(titles: result.titles)
                    ScriptCard(script: result.script)
                    StoryboardCard(items: result.storyboards)
                    CoverTextCard(items: result.coverTexts)
                    TagsCard(tags: result.tags)
                } else {
                    EmptyStateView(text: "暂无结果")
                }
            }
            .padding()
        }
        .navigationTitle("生成结果")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if let result {
                    Button("全部复制") {
                        let merged = (["推荐标题:"] + result.titles + ["", "视频文案:", result.script, "", "分镜脚本:"] + result.storyboards + ["", "封面文案:"] + result.coverTexts + ["", "标签:"] + result.tags).joined(separator: "\n")
                        ClipboardService.copy(merged)
                    }
                }
            }
        }
    }
}
