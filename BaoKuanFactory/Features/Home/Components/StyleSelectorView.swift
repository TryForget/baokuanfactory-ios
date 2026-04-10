import SwiftUI

struct StyleSelectorView: View {
    @Binding var selectedStyle: VideoStyle
    let styles: [VideoStyle]

    var body: some View {
        SectionCard(title: "选择风格") {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 12) {
                ForEach(styles) { style in
                    Button {
                        selectedStyle = style
                    } label: {
                        Text(style.displayName)
                            .font(.subheadline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(selectedStyle == style ? AppColors.primary : Color(.secondarySystemBackground))
                            .foregroundStyle(selectedStyle == style ? .white : .primary)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}
