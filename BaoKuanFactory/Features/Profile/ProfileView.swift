import SwiftUI

struct ProfileView: View {
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text("游客用户")
                        .font(.headline)
                    Text("当前版本：免费版")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    NavigationLink("解锁会员", destination: MembershipView())
                }
                .padding(.vertical, 8)
            }

            Section("功能") {
                NavigationLink("会员中心", destination: MembershipView())
                NavigationLink("设置", destination: SettingsView())
            }

            Section("其他") {
                Link("隐私政策", destination: URL(string: "https://example.com/privacy")!)
                Link("用户协议", destination: URL(string: "https://example.com/terms")!)
            }
        }
        .navigationTitle("我的")
    }
}
