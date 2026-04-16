import UIKit

final class ClipboardService {
    static func copy(_ text: String) {
        UIPasteboard.general.string = text
    }
}
