import SwiftUI

struct RecentHistorySection: View {
    let items: [HistoryItem]

    var body: some View {
        SectionCard(title: "最近生成") {
            if items.isEmpty {
                Text("还没有生成记录，先做一条看看效果。")
                    .foregroundStyle(AppColors.textSecondary)
            } else {
                VStack(spacing: 12) {
                    ForEach(items) { item in
                        HStack(alignment: .top, spacing: 12) {
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(AppColors.buttonGradient)
                                .frame(width: 10)

                            VStack(alignment: .leading, spacing: 6) {
                                Text(item.title)
                                    .font(.headline)
                                    .foregroundStyle(AppColors.textPrimary)
                                Text("\(item.style.displayName) · \(item.duration.displayName)")
                                    .font(.caption)
                                    .foregroundStyle(AppColors.textSecondary)
                            }
                            Spacer()
                        }
                        .padding(14)
                        .background(AppColors.mutedCard)
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    }
                }
            }
        }
    }
}
