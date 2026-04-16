import SwiftUI

struct StyleSelectorView: View {
    @Binding var selectedStyle: VideoStyle
    let styles: [VideoStyle]

    var body: some View {
        SectionCard(title: "选择爆款表达风格") {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 108), spacing: 12)], spacing: 12) {
                ForEach(styles) { style in
                    Button {
                        selectedStyle = style
                    } label: {
                        VStack(alignment: .leading, spacing: 10) {
                            Image(systemName: style.icon)
                                .font(.headline)
                            Text(style.displayName)
                                .font(.subheadline.weight(.semibold))
                                .multilineTextAlignment(.leading)
                        }
                        .foregroundStyle(selectedStyle == style ? .white : AppColors.textPrimary)
                        .frame(maxWidth: .infinity, minHeight: 92, alignment: .leading)
                        .padding(14)
                        .background(selectedStyle == style ? AnyShapeStyle(AppColors.heroGradient) : AnyShapeStyle(AppColors.mutedCard))
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                        .overlay {
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .stroke(selectedStyle == style ? Color.white.opacity(0.35) : Color.white.opacity(0.8), lineWidth: 1)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}
