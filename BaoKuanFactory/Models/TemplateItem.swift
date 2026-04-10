import Foundation

struct TemplateItem: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let subtitle: String
    let topic: String
    let style: VideoStyle
}

struct TemplateCategory: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let items: [TemplateItem]
}
