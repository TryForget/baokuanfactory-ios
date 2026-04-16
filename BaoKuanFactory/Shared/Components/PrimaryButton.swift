import SwiftUI

struct PrimaryButton: View {
    let title: String
    var isDisabled: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Image(systemName: "sparkles")
                    .font(.headline)
                Text(title)
                    .font(.headline)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(isDisabled ? AnyShapeStyle(Color.gray.opacity(0.35)) : AnyShapeStyle(AppColors.buttonGradient))
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .shadow(color: isDisabled ? .clear : AppColors.primary.opacity(0.28), radius: 16, x: 0, y: 10)
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
    }
}
