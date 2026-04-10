import SwiftUI

struct StoryboardCard: View {
    let items: [String]

    var body: some View {
        SectionCard(title: "分镜脚本") {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(items, id: \.self) { item in
                    Text("• \(item)")
                }
                HStack {
                    Spacer()
                    CopyButton(text: items.joined(separator: "\n"))
                }
            }
        }
    }
}
