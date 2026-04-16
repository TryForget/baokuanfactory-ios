import SwiftUI

struct TagsCard: View {
    let tags: [String]

    var body: some View {
        SectionCard(title: "推荐标签") {
            VStack(alignment: .leading, spacing: 12) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 88), spacing: 10)], spacing: 10) {
                    ForEach(tags, id: \.self) { tag in
                        Text(tag)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(AppColors.textPrimary)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(AppColors.mutedCard)
                            .clipShape(Capsule())
                    }
                }

                HStack {
                    Spacer()
                    CopyButton(text: tags.joined(separator: " "))
                }
            }
        }
    }
}
