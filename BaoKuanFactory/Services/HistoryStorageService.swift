import Foundation

final class HistoryStorageService {
    private let key = "baokuanfactory.history"

    func load() -> [HistoryItem] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let items = try? JSONDecoder().decode([HistoryItem].self, from: data) else {
            return []
        }
        return items.sorted { $0.createdAt > $1.createdAt }
    }

    func save(_ items: [HistoryItem]) {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func append(_ item: HistoryItem) {
        var items = load()
        items.insert(item, at: 0)
        save(items)
    }
}
