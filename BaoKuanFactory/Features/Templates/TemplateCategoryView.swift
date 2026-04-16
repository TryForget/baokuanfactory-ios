import SwiftUI

struct TemplateCategoryView: View {
    let template: TemplateItem

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(template.title)
                        .font(.system(size: 30, weight: .heavy))
                        .foregroundStyle(.white)
                    Text(template.subtitle)
                        .foregroundStyle(.white.opacity(0.82))
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(AppColors.heroGradient)
                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))

                SectionCard(title: "预设主题") {
                    Text(template.topic)
                        .font(.body.weight(.semibold))
                        .foregroundStyle(AppColors.textPrimary)
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(AppColors.mutedCard)
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                }

                SectionCard(title: "适合内容方向") {
                    Text("适合拿来做 \(template.style.displayName) 风格的短视频开题，尤其适合想快速进入状态、先拿到一版成稿的人。")
                        .foregroundStyle(AppColors.textSecondary)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("模板详情")
        .navigationBarTitleDisplayMode(.inline)
    }
}
