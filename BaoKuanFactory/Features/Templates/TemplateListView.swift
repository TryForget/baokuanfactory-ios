import SwiftUI

struct TemplateListView: View {
    let categories: [TemplateCategory] = [
        TemplateCategory(name: "热门模板", items: [
            TemplateItem(id: UUID(), title: "情绪共鸣", subtitle: "适合治愈、成长、表达类内容", topic: "真正救你的只有你自己", style: .emotion),
            TemplateItem(id: UUID(), title: "国漫燃向", subtitle: "适合逆袭、觉醒、热血短视频", topic: "你以为那是绝路，其实是命在逼你变强", style: .anime)
        ])
    ]

    var body: some View {
        List {
            ForEach(categories) { category in
                Section(category.name) {
                    ForEach(category.items) { item in
                        NavigationLink {
                            TemplateCategoryView(template: item)
                        } label: {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(item.title)
                                    .font(.headline)
                                Text(item.subtitle)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("爆款模板")
    }
}
