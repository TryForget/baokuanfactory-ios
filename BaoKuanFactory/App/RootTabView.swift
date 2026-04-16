import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("发现", systemImage: "sparkles")
            }

            NavigationStack {
                TemplateListView()
            }
            .tabItem {
                Label("灵感", systemImage: "square.grid.2x2")
            }

            NavigationStack {
                HistoryListView()
            }
            .tabItem {
                Label("作品", systemImage: "clock.arrow.circlepath")
            }

            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label("我的", systemImage: "person.crop.circle")
            }
        }
        .tint(AppColors.primary)
    }
}
