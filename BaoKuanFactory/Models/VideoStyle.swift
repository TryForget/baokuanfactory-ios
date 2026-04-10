import Foundation

enum VideoStyle: String, CaseIterable, Codable, Identifiable {
    case emotion
    case motivation
    case talking
    case women
    case boss
    case sales
    case workplace
    case anime

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .emotion: return "情绪共鸣"
        case .motivation: return "励志逆袭"
        case .talking: return "口播干货"
        case .women: return "女性成长"
        case .boss: return "老板创业"
        case .sales: return "带货种草"
        case .workplace: return "职场表达"
        case .anime: return "国漫燃向"
        }
    }
}
