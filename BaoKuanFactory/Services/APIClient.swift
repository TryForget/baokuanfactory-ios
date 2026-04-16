import Foundation

struct APIClient {
    private let session: URLSession
    private let environment: AppEnvironment
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    init(session: URLSession = .shared, environment: AppEnvironment = .current) {
        self.session = session
        self.environment = environment
    }

    func generateScript(topic: String, style: VideoStyle, duration: VideoDuration) async throws -> ScriptResult {
        let request = try makeGenerateScriptRequest(topic: topic, style: style, duration: duration)
        let data = try await performRequestWithRetry(request)

        do {
            let decoded = try decoder.decode(GenerateScriptResponse.self, from: data)
            return try decoded.toDomainModel()
        } catch let apiError as APIError {
            throw apiError
        } catch {
            throw APIError.decodingFailed
        }
    }

    private func makeGenerateScriptRequest(topic: String, style: VideoStyle, duration: VideoDuration) throws -> URLRequest {
        guard !environment.apiBaseURL.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw APIError.missingBaseURL
        }

        guard let url = URL(string: environment.apiBaseURL + "/generate-script") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 30
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if !environment.apiToken.isEmpty {
            request.setValue("Bearer \(environment.apiToken)", forHTTPHeaderField: "Authorization")
        }

        request.httpBody = try encoder.encode(
            GenerateScriptRequest(
                topic: topic,
                style: style.rawValue,
                duration: duration.rawValue
            )
        )

        return request
    }

    private func performRequestWithRetry(_ request: URLRequest) async throws -> Data {
        var lastError: APIError?

        for attempt in 0 ... environment.maxRetryCount {
            do {
                let (data, response) = try await session.data(for: request)
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }

                guard (200 ... 299).contains(httpResponse.statusCode) else {
                    let mappedError = mapHTTPError(statusCode: httpResponse.statusCode, data: data)
                    if shouldRetry(statusCode: httpResponse.statusCode, attempt: attempt) {
                        lastError = mappedError
                        try await sleepBeforeRetry(attempt: attempt)
                        continue
                    }
                    throw mappedError
                }

                return data
            } catch let apiError as APIError {
                lastError = apiError
                if shouldRetry(error: apiError, attempt: attempt) {
                    try await sleepBeforeRetry(attempt: attempt)
                    continue
                }
                throw apiError
            } catch {
                let mappedError = mapNetworkError(error)
                lastError = mappedError
                if shouldRetry(error: mappedError, attempt: attempt) {
                    try await sleepBeforeRetry(attempt: attempt)
                    continue
                }
                throw mappedError
            }
        }

        throw lastError ?? APIError.networkError(message: "请求失败，请稍后再试")
    }

    private func shouldRetry(statusCode: Int, attempt: Int) -> Bool {
        guard attempt < environment.maxRetryCount else { return false }
        return statusCode == 429 || (500 ... 599).contains(statusCode)
    }

    private func shouldRetry(error: APIError, attempt: Int) -> Bool {
        guard attempt < environment.maxRetryCount else { return false }

        switch error {
        case .networkError:
            return true
        case .rateLimited:
            return true
        case .serverError(let statusCode, _):
            return (500 ... 599).contains(statusCode)
        default:
            return false
        }
    }

    private func sleepBeforeRetry(attempt: Int) async throws {
        let multiplier = Int(pow(2.0, Double(attempt)))
        let delay = UInt64(environment.retryBaseDelayMilliseconds * multiplier) * 1_000_000
        try await Task.sleep(nanoseconds: delay)
    }

    private func mapNetworkError(_ error: Error) -> APIError {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .timedOut:
                return .networkError(message: "请求超时了，请稍后重试")
            case .notConnectedToInternet:
                return .networkError(message: "当前网络不可用，请检查连接")
            case .cannotFindHost, .cannotConnectToHost, .dnsLookupFailed:
                return .networkError(message: "无法连接到生成服务，请检查接口地址")
            case .networkConnectionLost:
                return .networkError(message: "网络连接中断，正在重试")
            default:
                return .networkError(message: "网络请求失败，请稍后再试")
            }
        }

        return .networkError(message: "网络请求失败，请稍后再试")
    }

    private func mapHTTPError(statusCode: Int, data: Data) -> APIError {
        let responseMessage = decodeErrorMessage(from: data)

        switch statusCode {
        case 400:
            return .invalidRequest(message: responseMessage ?? "请求参数有误，请检查后重试")
        case 401:
            return .unauthorized(message: buildUnauthorizedMessage(from: responseMessage))
        case 429:
            return .rateLimited(message: responseMessage ?? "请求太频繁了，请稍后再试")
        default:
            return .serverError(statusCode: statusCode, message: responseMessage)
        }
    }

    private func buildUnauthorizedMessage(from responseMessage: String?) -> String {
        let normalizedMessage = responseMessage?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if normalizedMessage == "Invalid token" || normalizedMessage.isEmpty {
            if environment.apiToken.isEmpty {
                return "当前后端已开启鉴权，请在 Xcode Scheme 里配置 BAOKUAN_API_TOKEN"
            }
            return "接口鉴权失败，请检查 BAOKUAN_API_TOKEN 是否与后端一致"
        }

        return normalizedMessage
    }

    private func decodeErrorMessage(from data: Data) -> String? {
        guard !data.isEmpty,
              let payload = try? decoder.decode(APIErrorEnvelope.self, from: data) else {
            return nil
        }

        return payload.error.message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            ? nil
            : payload.error.message
    }
}

private struct APIErrorEnvelope: Decodable {
    let error: APIErrorPayload
}

private struct APIErrorPayload: Decodable {
    let code: String
    let message: String
}
