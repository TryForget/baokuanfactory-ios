import SwiftUI

struct TagsCard: View {
    let tags: [String]

    var body: some View {
        SectionCard(title: "推荐标签") {
            VStack(alignment: .leading, spacing: 12) {
                Text(tags.joined(separator: " "))
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Spacer()
                    CopyButton(text: tags.joined(separator: " "))
                }
            }
        }
    }
}
