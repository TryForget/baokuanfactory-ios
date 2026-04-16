import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var appSettings: AppSettings
    @EnvironmentObject private var membershipService: MembershipService

    var body: some View {
        List {
            Section("通用") {
                Toggle("允许推送提醒", isOn: $appSettings.notificationsEnabled)
                Toggle("自动保存历史", isOn: $appSettings.autoSaveHistory)
            }

            Section("账号") {
                HStack {
                    Text("当前方案")
                    Spacer()
                    Text(membershipService.currentPlan.title)
                        .foregroundStyle(.secondary)
                }

                if membershipService.isPremium {
                    Button("切回免费版（演示）", role: .destructive) {
                        membershipService.restoreFreePlan()
                    }
                }
            }
        }
        .navigationTitle("设置")
    }
}
