import Foundation

enum VideoDuration: String, CaseIterable, Codable, Identifiable {
    case fifteen
    case thirty
    case sixty

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .fifteen: return "15秒"
        case .thirty: return "30秒"
        case .sixty: return "60秒"
        }
    }

    var highlight: String {
        switch self {
        case .fifteen: return "快节奏"
        case .thirty: return "最稳妥"
        case .sixty: return "更完整"
        }
    }
}
