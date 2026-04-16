import SwiftUI
import Combine

@MainActor
final class HistoryViewModel: ObservableObject {
    @Published var items: [HistoryItem] = []

    private let storage = HistoryStorageService()

    init() {
        items = storage.load()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        storage.save(items)
    }
}
