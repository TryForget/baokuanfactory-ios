import SwiftUI

struct TemplateListView: View {
    let categories: [TemplateCategory] = [
        TemplateCategory(name: "热门模板", items: [
            TemplateItem(id: UUID(), title: "情绪共鸣", subtitle: "适合治愈、成长、表达类内容", topic: "真正救你的只有你自己", style: .emotion),
            TemplateItem(id: UUID(), title: "国漫燃向", subtitle: "适合逆袭、觉醒、热血短视频", topic: "你以为那是绝路，其实是命在逼你变强", style: .anime)
        ])
    ]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("平台热门模板")
                        .font(.system(size: 28, weight: .heavy))
                        .foregroundStyle(AppColors.textPrimary)
                    Text("直接套用热门表达方式，快速切进能起量的内容方向。")
                        .font(.subheadline)
                        .foregroundStyle(AppColors.textSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                ForEach(categories) { category in
                    SectionCard(title: category.name) {
                        VStack(spacing: 12) {
                            ForEach(category.items) { item in
                                NavigationLink {
                                    TemplateCategoryView(template: item)
                                } label: {
                                    HStack(alignment: .top, spacing: 12) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                                .fill(AppColors.heroGradient)
                                                .frame(width: 56, height: 56)
                                            Image(systemName: item.style.icon)
                                                .foregroundStyle(.white)
                                        }

                                        VStack(alignment: .leading, spacing: 6) {
                                            Text(item.title)
                                                .font(.headline)
                                                .foregroundStyle(AppColors.textPrimary)
                                            Text(item.subtitle)
                                                .font(.subheadline)
                                                .foregroundStyle(AppColors.textSecondary)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundStyle(AppColors.textSecondary)
                                    }
                                    .padding(14)
                                    .background(AppColors.mutedCard)
                                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("爆款模板")
        .navigationBarTitleDisplayMode(.inline)
    }
}
