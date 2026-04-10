import SwiftUI

struct CoverTextCard: View {
    let items: [String]

    var body: some View {
        SectionCard(title: "封面文案") {
            VStack(spacing: 12) {
                ForEach(items, id: \.self) { item in
                    HStack {
                        Text(item)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        CopyButton(text: item)
                    }
                }
            }
        }
    }
}
