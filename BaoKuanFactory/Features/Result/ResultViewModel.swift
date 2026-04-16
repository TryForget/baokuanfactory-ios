import Foundation
import Combine

@MainActor
final class ResultViewModel: ObservableObject {
    @Published var isSaved = false
}
