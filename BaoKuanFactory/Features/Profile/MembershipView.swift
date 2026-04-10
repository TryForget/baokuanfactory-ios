import SwiftUI

struct MembershipView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("解锁无限生成")
                    .font(AppTypography.title)
                Text("开通会员后可使用全部模板、无限生成、更强标题结果。")
                    .foregroundStyle(.secondary)

                SectionCard(title: "会员权益") {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("• 无限生成")
                        Text("• 解锁全部模板")
                        Text("• 历史记录不限量")
                        Text("• 优先体验新模板")
                    }
                }

                SectionCard(title: "订阅方案") {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("月会员 ¥28")
                        Text("年会员 ¥198")
                    }
                }

                PrimaryButton(title: "立即开通") {}
            }
            .padding()
        }
        .navigationTitle("会员中心")
    }
}
