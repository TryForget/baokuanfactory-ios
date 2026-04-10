import SwiftUI

struct DurationSelectorView: View {
    @Binding var selectedDuration: VideoDuration

    var body: some View {
        SectionCard(title: "选择时长") {
            HStack(spacing: 12) {
                ForEach(VideoDuration.allCases) { duration in
                    Button {
                        selectedDuration = duration
                    } label: {
                        Text(duration.displayName)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(selectedDuration == duration ? Color.black : Color(.secondarySystemBackground))
                            .foregroundStyle(selectedDuration == duration ? .white : .primary)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}
