import SwiftUI

struct StoryboardCard: View {
    let items: [String]

    var body: some View {
        SectionCard(title: "分镜脚本") {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    HStack(alignment: .top, spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(AppColors.buttonGradient)
                                .frame(width: 28, height: 28)
                            Text("\(index + 1)")
                                .font(.caption.weight(.bold))
                                .foregroundStyle(.white)
                        }
                        Text(item)
                            .foregroundStyle(AppColors.textPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(14)
                    .background(AppColors.mutedCard)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                }
                HStack {
                    Spacer()
                    CopyButton(text: items.joined(separator: "\n"))
                }
            }
        }
    }
}
