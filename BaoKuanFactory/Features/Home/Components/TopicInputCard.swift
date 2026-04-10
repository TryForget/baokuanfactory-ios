import SwiftUI

struct TopicInputCard: View {
    @Binding var topic: String

    var body: some View {
        SectionCard(title: "输入主题") {
            VStack(alignment: .leading, spacing: 10) {
                TextField("例如：女人清醒、创业很难、国漫逆袭", text: $topic, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(3...5)

                Text("输入一个想表达的主题，我们帮你生成可发内容")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
