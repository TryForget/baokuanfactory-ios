import SwiftUI

struct HistoryListView: View {
    @StateObject private var viewModel = HistoryViewModel()

    var body: some View {
        List {
            ForEach(viewModel.items) { item in
                NavigationLink {
                    HistoryDetailView(item: item)
                } label: {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(item.title)
                            .font(.headline)

                        Text("\(item.style.displayName) · \(item.duration.displayName)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        Text(item.createdAt.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                    }
                }
            }
            .onDelete(perform: viewModel.delete)
        }
        .navigationTitle("历史记录")
    }
}
