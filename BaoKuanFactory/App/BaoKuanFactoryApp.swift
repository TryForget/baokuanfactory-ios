import SwiftUI

@main
struct BaoKuanFactoryApp: App {
    @StateObject private var membershipService = MembershipService()
    @StateObject private var appSettings = AppSettings()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(membershipService)
                .environmentObject(appSettings)
        }
    }
}
