import SwiftUI

struct ScriptCard: View {
    let script: String

    var body: some View {
        SectionCard(title: "视频文案") {
            VStack(alignment: .leading, spacing: 14) {
                Text(script)
                    .font(.body)
                    .foregroundStyle(AppColors.textPrimary)
                    .lineSpacing(6)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                    .background(AppColors.mutedCard)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                HStack {
                    Spacer()
                    CopyButton(text: script)
                }
            }
        }
    }
}
