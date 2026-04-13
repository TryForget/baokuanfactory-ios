import Foundation

struct APIClient {
    private let session: URLSession
    private let environment: AppEnvironment

    init(session: URLSession = .shared, environment: AppEnvironment = .current) {
        self.session = session
        self.environment = environment
    }

    func generateScript(topic: String, style: VideoStyle, duration: VideoDuration) async throws -> ScriptResult {
        guard !environment.apiBaseURL.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw APIError.missingBaseURL
        }

        guard let url = URL(string: environment.apiBaseURL + "/generate-script") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(
            GenerateScriptRequest(
                topic: topic,
                style: style.rawValue,
                duration: duration.rawValue
            )
        )

        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard (200 ... 299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(statusCode: httpResponse.statusCode)
        }

        do {
            let decoded = try JSONDecoder().decode(GenerateScriptResponse.self, from: data)
            return decoded.toDomainModel()
        } catch {
            throw APIError.decodingFailed
        }
    }
}
