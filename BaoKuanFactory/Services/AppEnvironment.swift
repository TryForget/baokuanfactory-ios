import Foundation

struct AppEnvironment {
    let apiBaseURL: String
    let usesMockGenerator: Bool
    let apiToken: String
    let maxRetryCount: Int
    let retryBaseDelayMilliseconds: Int

    static let current: AppEnvironment = {
        let processInfo = ProcessInfo.processInfo
        let configuredBaseURL = processInfo.environment["BAOKUAN_API_BASE_URL"]?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let configuredToken = processInfo.environment["BAOKUAN_API_TOKEN"]?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let useMockFlag = processInfo.environment["BAOKUAN_USE_MOCK"]?
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        let retryCount = Int(processInfo.environment["BAOKUAN_API_RETRY_COUNT"] ?? "") ?? 2
        let retryDelay = Int(processInfo.environment["BAOKUAN_API_RETRY_DELAY_MS"] ?? "") ?? 800

        let resolvedUsesMockGenerator: Bool
        switch useMockFlag {
        case "0", "false", "no":
            resolvedUsesMockGenerator = false
        case "1", "true", "yes":
            resolvedUsesMockGenerator = true
        default:
            resolvedUsesMockGenerator = configuredBaseURL.isEmpty
        }

        return AppEnvironment(
            apiBaseURL: configuredBaseURL,
            usesMockGenerator: resolvedUsesMockGenerator,
            apiToken: configuredToken,
            maxRetryCount: max(0, retryCount),
            retryBaseDelayMilliseconds: max(100, retryDelay)
        )
    }()
}
