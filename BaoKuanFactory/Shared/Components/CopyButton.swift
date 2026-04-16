import SwiftUI

struct CopyButton: View {
    let text: String

    var body: some View {
        Button {
            ClipboardService.copy(text)
        } label: {
            HStack(spacing: 6) {
                Image(systemName: "doc.on.doc.fill")
                    .font(.caption)
                Text("复制")
                    .font(.caption.weight(.semibold))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(AppColors.buttonGradient.opacity(0.14))
            .foregroundStyle(AppColors.primary)
            .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}
