import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(statusCode: Int)
    case decodingFailed
    case missingBaseURL

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "接口地址无效"
        case .invalidResponse:
            return "服务返回异常，请稍后再试"
        case .serverError(let statusCode):
            return "服务暂时不可用（\(statusCode)）"
        case .decodingFailed:
            return "返回数据解析失败"
        case .missingBaseURL:
            return "尚未配置生成接口地址"
        }
    }
}
