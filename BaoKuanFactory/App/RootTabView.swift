import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("首页", systemImage: "sparkles")
            }

            NavigationStack {
                TemplateListView()
            }
            .tabItem {
                Label("模板", systemImage: "square.grid.2x2")
            }

            NavigationStack {
                HistoryListView()
            }
            .tabItem {
                Label("历史", systemImage: "clock.arrow.circlepath")
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
