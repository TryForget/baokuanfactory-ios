import SwiftUI

struct ScriptCard: View {
    let script: String

    var body: some View {
        SectionCard(title: "视频文案") {
            VStack(alignment: .leading, spacing: 12) {
                Text(script)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Spacer()
                    CopyButton(text: script)
                }
            }
        }
    }
}
