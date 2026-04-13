import Foundation

struct AppEnvironment {
    let apiBaseURL: String
    let usesMockGenerator: Bool

    static let current = AppEnvironment(
        apiBaseURL: "",
        usesMockGenerator: true
    )
}
