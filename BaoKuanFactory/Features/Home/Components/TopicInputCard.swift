import SwiftUI

struct TopicInputCard: View {
    @Binding var topic: String

    var body: some View {
        SectionCard(title: "本条想讲什么") {
            VStack(alignment: .leading, spacing: 12) {
                TextField("例如：女人清醒、创业很难、国漫逆袭", text: $topic, axis: .vertical)
                    .padding(16)
                    .background(AppColors.mutedCard)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .lineLimit(3...5)

                Text("输入一个主题，我们直接给你出标题、口播稿、分镜和封面文案。")
                    .font(.footnote)
                    .foregroundStyle(AppColors.textSecondary)
            }
        }
    }
}
