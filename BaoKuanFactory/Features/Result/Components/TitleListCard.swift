import SwiftUI

struct TitleListCard: View {
    let titles: [String]

    var body: some View {
        SectionCard(title: "推荐标题") {
            VStack(spacing: 12) {
                ForEach(titles, id: \.self) { title in
                    HStack(alignment: .top, spacing: 12) {
                        Text(title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        CopyButton(text: title)
                    }
                }
            }
        }
    }
}
