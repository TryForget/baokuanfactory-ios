import SwiftUI

struct CopyButton: View {
    let text: String

    var body: some View {
        Button {
            ClipboardService.copy(text)
        } label: {
            Text("复制")
                .font(.caption)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.orange.opacity(0.12))
                .foregroundStyle(AppColors.primary)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}
