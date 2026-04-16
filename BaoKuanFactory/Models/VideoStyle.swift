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

    var icon: String {
        switch self {
        case .emotion: return "heart.fill"
        case .motivation: return "flame.fill"
        case .talking: return "mic.fill"
        case .women: return "sparkles"
        case .boss: return "briefcase.fill"
        case .sales: return "bag.fill"
        case .workplace: return "building.2.fill"
        case .anime: return "bolt.fill"
        }
    }
}
