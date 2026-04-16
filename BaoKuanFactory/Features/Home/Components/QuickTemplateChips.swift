import SwiftUI

struct QuickTemplateChips: View {
    let items: [String]
    let onTap: (String) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(items, id: \.self) { item in
                    Button(item) {
                        onTap(item)
                    }
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(AppColors.textPrimary)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(AppColors.mutedCard)
                    .overlay {
                        Capsule().stroke(Color.white.opacity(0.9), lineWidth: 1)
                    }
                    .clipShape(Capsule())
                }
            }
            .padding(.vertical, 2)
        }
    }
}
