import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidRequest(message: String)
    case unauthorized(message: String)
    case rateLimited(message: String)
    case serverError(statusCode: Int, message: String?)
    case networkError(message: String)
    case emptyResponse
    case decodingFailed
    case missingBaseURL

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "接口地址无效"
        case .invalidResponse:
            return "服务返回异常，请稍后再试"
        case .invalidRequest(let message):
            return message
        case .unauthorized(let message):
            return message
        case .rateLimited(let message):
            return message
        case .serverError(let statusCode, let message):
            return message ?? "服务暂时不可用（\(statusCode)）"
        case .networkError(let message):
            return message
        case .emptyResponse:
            return "服务返回了空内容，请稍后再试"
        case .decodingFailed:
            return "返回数据解析失败"
        case .missingBaseURL:
            return "尚未配置生成接口地址"
        }
    }
}
