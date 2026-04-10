import SwiftUI

struct TemplateCategoryView: View {
    let template: TemplateItem

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(template.title)
                .font(AppTypography.title)
            Text(template.subtitle)
                .foregroundStyle(.secondary)
            SectionCard(title: "预设主题") {
                Text(template.topic)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("模板详情")
    }
}
