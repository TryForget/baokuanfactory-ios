import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section("通用") {
                Toggle("允许推送提醒", isOn: .constant(true))
                Toggle("自动保存历史", isOn: .constant(true))
            }
        }
        .navigationTitle("设置")
    }
}
