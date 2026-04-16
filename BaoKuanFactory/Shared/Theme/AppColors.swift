import SwiftUI

enum AppColors {
    static let primary = Color(red: 1.0, green: 0.42, blue: 0.16)
    static let secondary = Color(red: 1.0, green: 0.76, blue: 0.18)
    static let accent = Color(red: 0.10, green: 0.07, blue: 0.16)
    static let background = Color(red: 0.97, green: 0.95, blue: 0.92)
    static let cardBackground = Color.white
    static let mutedCard = Color(red: 0.95, green: 0.92, blue: 0.88)
    static let textPrimary = Color(red: 0.10, green: 0.07, blue: 0.16)
    static let textSecondary = Color(red: 0.42, green: 0.37, blue: 0.34)

    static let heroGradient = LinearGradient(
        colors: [
            Color(red: 0.10, green: 0.07, blue: 0.16),
            Color(red: 0.38, green: 0.14, blue: 0.30),
            Color(red: 1.0, green: 0.42, blue: 0.16)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let buttonGradient = LinearGradient(
        colors: [primary, secondary],
        startPoint: .leading,
        endPoint: .trailing
    )
}
