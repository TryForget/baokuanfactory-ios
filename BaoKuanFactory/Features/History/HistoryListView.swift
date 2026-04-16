import SwiftUI

struct HistoryListView: View {
    @StateObject private var viewModel = HistoryViewModel()

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                if viewModel.items.isEmpty {
                    EmptyStateView(text: "还没有生成记录，先去首页做第一条内容吧")
                        .padding(.horizontal)
                } else {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("你的内容工作台")
                            .font(.system(size: 28, weight: .heavy))
                            .foregroundStyle(AppColors.textPrimary)
                        Text("最近生成过的标题、文案和分镜都会留在这里，方便二次改写和复用。")
                            .font(.subheadline)
                            .foregroundStyle(AppColors.textSecondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)

                    VStack(spacing: 12) {
                        ForEach(viewModel.items) { item in
                            NavigationLink {
                                HistoryDetailView(item: item)
                            } label: {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(item.title)
                                        .font(.headline)
                                        .foregroundStyle(AppColors.textPrimary)

                                    Text("\(item.style.displayName) · \(item.duration.displayName)")
                                        .font(.subheadline)
                                        .foregroundStyle(AppColors.textSecondary)

                                    Text(item.createdAt.formatted(date: .abbreviated, time: .shortened))
                                        .font(.caption)
                                        .foregroundStyle(AppColors.textSecondary)

                                    if let requestId = item.requestId, !requestId.isEmpty {
                                        Text("请求 ID: \(requestId)")
                                            .font(.caption2)
                                            .foregroundStyle(AppColors.textSecondary)
                                    }
                                }
                                .padding(16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(AppColors.cardBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                                .shadow(color: Color.black.opacity(0.06), radius: 14, x: 0, y: 8)
                            }
                            .buttonStyle(.plain)
                            .padding(.horizontal, 16)
                        }
                    }
                }
            }
            .padding(.vertical, 14)
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("历史记录")
        .navigationBarTitleDisplayMode(.inline)
    }
}
