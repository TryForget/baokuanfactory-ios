import SwiftUI

struct HistoryDetailView: View {
    let item: HistoryItem

    var body: some View {
        ResultView(result: item.result)
            .navigationTitle("历史详情")
    }
}
