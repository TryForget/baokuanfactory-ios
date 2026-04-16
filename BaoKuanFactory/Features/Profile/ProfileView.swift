import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var membershipService: MembershipService

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(membershipService.isPremium ? "会员创作账号" : "创作体验账号")
                        .font(.system(size: 28, weight: .heavy))
                        .foregroundStyle(.white)
                    Text(membershipService.isPremium ? "已解锁无限生成和全部模板" : "继续解锁会员能力，让你的内容生产效率拉满")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.84))

                    HStack(spacing: 12) {
                        profileStat(title: "当前版本", value: membershipService.currentPlan.title)
                        profileStat(title: "剩余次数", value: membershipService.isPremium ? "无限" : "\(membershipService.remainingFreeGenerations)")
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(AppColors.heroGradient)
                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                .shadow(color: AppColors.primary.opacity(0.24), radius: 24, x: 0, y: 14)

                SectionCard(title: "账号功能") {
                    VStack(spacing: 12) {
                        NavigationLink("会员中心", destination: MembershipView())
                        NavigationLink("设置", destination: SettingsView())
                    }
                    .tint(AppColors.textPrimary)
                }

                if !membershipService.isPremium {
                    SectionCard(title: "升级建议") {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("开通会员后可解锁无限生成、全部模板和更顺滑的创作体验。")
                                .foregroundStyle(AppColors.textSecondary)
                            NavigationLink("立即解锁会员", destination: MembershipView())
                                .font(.headline)
                                .foregroundStyle(AppColors.primary)
                        }
                    }
                }

                SectionCard(title: "其他") {
                    VStack(spacing: 12) {
                        Link("隐私政策", destination: URL(string: "https://example.com/privacy")!)
                        Link("用户协议", destination: URL(string: "https://example.com/terms")!)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .tint(AppColors.textPrimary)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("我的")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func profileStat(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundStyle(AppColors.textSecondary)
            Text(value)
                .font(.subheadline.weight(.bold))
                .foregroundStyle(AppColors.textPrimary)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}
