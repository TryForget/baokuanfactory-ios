import SwiftUI

struct CoverTextCard: View {
    let items: [String]

    var body: some View {
        SectionCard(title: "封面文案") {
            VStack(spacing: 12) {
                ForEach(items, id: \.self) { item in
                    HStack(spacing: 12) {
                        Text(item)
                            .font(.title3.weight(.heavy))
                            .foregroundStyle(AppColors.textPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        CopyButton(text: item)
                    }
                    .padding(16)
                    .background(AppColors.mutedCard)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                }
            }
        }
    }
}
