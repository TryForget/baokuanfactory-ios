import Foundation
import Combine

@MainActor
final class MembershipService: ObservableObject {
    @Published private(set) var isPremium: Bool
    @Published private(set) var currentPlan: MembershipPlan
    @Published private(set) var remainingFreeGenerations: Int

    private let userDefaults: UserDefaults
    private let premiumKey = "membership.isPremium"
    private let planKey = "membership.currentPlan"
    private let remainingKey = "membership.remainingFreeGenerations"

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults

        let storedIsPremium = userDefaults.object(forKey: premiumKey) as? Bool ?? false
        let storedPlanRawValue = userDefaults.string(forKey: planKey)
        let storedPlan = storedPlanRawValue.flatMap(MembershipPlan.init(rawValue:)) ?? .free
        let storedRemaining = userDefaults.object(forKey: remainingKey) as? Int ?? MembershipPlan.free.generationLimit

        self.isPremium = storedIsPremium
        self.currentPlan = storedIsPremium ? storedPlan : .free
        self.remainingFreeGenerations = storedIsPremium ? MembershipPlan.premium.generationLimit : max(0, storedRemaining)
        persist()
    }

    func canGenerateMore() -> Bool {
        isPremium || remainingFreeGenerations > 0
    }

    func consumeGenerationIfNeeded() {
        guard !isPremium, remainingFreeGenerations > 0 else { return }
        remainingFreeGenerations -= 1
        persist()
    }

    func applyServerQuota(remainingQuota: Int?, isPremium: Bool?) {
        if let isPremium {
            self.isPremium = isPremium
            currentPlan = isPremium ? .premium : .free
        }

        if let remainingQuota {
            remainingFreeGenerations = max(0, remainingQuota)
        }

        persist()
    }

    func upgradeToPremium() {
        isPremium = true
        currentPlan = .premium
        remainingFreeGenerations = MembershipPlan.premium.generationLimit
        persist()
    }

    func restoreFreePlan(limit: Int = MembershipPlan.free.generationLimit) {
        isPremium = false
        currentPlan = .free
        remainingFreeGenerations = max(0, limit)
        persist()
    }

    private func persist() {
        userDefaults.set(isPremium, forKey: premiumKey)
        userDefaults.set(currentPlan.rawValue, forKey: planKey)
        userDefaults.set(remainingFreeGenerations, forKey: remainingKey)
    }
}

enum MembershipPlan: String {
    case free
    case premium

    var title: String {
        switch self {
        case .free:
            return "免费版"
        case .premium:
            return "会员版"
        }
    }

    var generationLimit: Int {
        switch self {
        case .free:
            return 5
        case .premium:
            return Int.max
        }
    }

    var description: String {
        switch self {
        case .free:
            return "可体验基础生成功能，适合先跑通流程。"
        case .premium:
            return "解锁无限生成、完整模板和优先体验能力。"
        }
    }
}
