import SwiftUI

struct DurationSelectorView: View {
    @Binding var selectedDuration: VideoDuration

    var body: some View {
        SectionCard(title: "这条内容打算做多长") {
            HStack(spacing: 12) {
                ForEach(VideoDuration.allCases) { duration in
                    Button {
                        selectedDuration = duration
                    } label: {
                        VStack(spacing: 6) {
                            Text(duration.displayName)
                                .font(.headline.weight(.bold))
                            Text(duration.highlight)
                                .font(.caption)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(selectedDuration == duration ? AnyShapeStyle(AppColors.buttonGradient) : AnyShapeStyle(AppColors.mutedCard))
                        .foregroundStyle(selectedDuration == duration ? .white : AppColors.textPrimary)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}
