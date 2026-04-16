import Foundation
import SwiftUI
import Combine

@MainActor
final class AppSettings: ObservableObject {
    @Published var notificationsEnabled: Bool {
        didSet {
            UserDefaults.standard.set(notificationsEnabled, forKey: "settings.notificationsEnabled")
        }
    }

    @Published var autoSaveHistory: Bool {
        didSet {
            UserDefaults.standard.set(autoSaveHistory, forKey: "settings.autoSaveHistory")
        }
    }

    init() {
        self.notificationsEnabled = UserDefaults.standard.object(forKey: "settings.notificationsEnabled") as? Bool ?? true
        self.autoSaveHistory = UserDefaults.standard.object(forKey: "settings.autoSaveHistory") as? Bool ?? true
    }
}
