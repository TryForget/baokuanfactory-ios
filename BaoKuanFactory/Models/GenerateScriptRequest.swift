import Foundation

struct GenerateScriptRequest: Encodable {
    let topic: String
    let style: String
    let duration: String
}
