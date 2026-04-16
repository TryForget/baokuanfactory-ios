import Foundation

struct HistoryItem: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let style: VideoStyle
    let duration: VideoDuration
    let result: ScriptResult
    let createdAt: Date
    let requestId: String?
}
