import SwiftUI

struct TitleListCard: View {
    let titles: [String]

    var body: some View {
        SectionCard(title: "推荐标题") {
            VStack(spacing: 12) {
                ForEach(Array(titles.enumerated()), id: \.offset) { index, title in
                    HStack(alignment: .top, spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(AppColors.buttonGradient)
                                .frame(width: 30, height: 30)
                            Text("\(index + 1)")
                                .font(.subheadline.weight(.bold))
                                .foregroundStyle(.white)
                        }

                        Text(title)
                            .font(.body.weight(.semibold))
                            .foregroundStyle(AppColors.textPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        CopyButton(text: title)
                    }
                    .padding(14)
                    .background(AppColors.mutedCard)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                }
            }
        }
    }
}
