import SwiftUI

struct MembershipView: View {
    @EnvironmentObject private var membershipService: MembershipService

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(membershipService.isPremium ? "你已经是会员啦" : "解锁无限生成")
                    .font(AppTypography.title)
                Text(membershipService.currentPlan.description)
                    .foregroundStyle(.secondary)

                SectionCard(title: "当前状态") {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("当前方案：\(membershipService.currentPlan.title)")
                        if membershipService.isPremium {
                            Text("剩余次数：无限")
                        } else {
                            Text("剩余免费生成：\(membershipService.remainingFreeGenerations) 次")
                        }
                    }
                }

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
                        Text("当前为本地演示开通逻辑，后续可替换为 StoreKit 2")
                            .font(AppTypography.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                if membershipService.isPremium {
                    PrimaryButton(title: "已开通", isDisabled: true) {}
                } else {
                    PrimaryButton(title: "立即开通") {
                        membershipService.upgradeToPremium()
                    }
                }
            }
            .padding()
        }
        .navigationTitle("会员中心")
    }
}
