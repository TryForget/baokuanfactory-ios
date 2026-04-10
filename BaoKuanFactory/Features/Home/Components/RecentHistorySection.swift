import SwiftUI

struct RecentHistorySection: View {
    let items: [HistoryItem]

    var body: some View {
        SectionCard(title: "最近生成") {
            if items.isEmpty {
                Text("还没有生成记录")
                    .foregroundStyle(.secondary)
            } else {
                VStack(spacing: 12) {
                    ForEach(items) { item in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title)
                                .font(.headline)
                            Text("\(item.style.displayName) · \(item.duration.displayName)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
    }
}
