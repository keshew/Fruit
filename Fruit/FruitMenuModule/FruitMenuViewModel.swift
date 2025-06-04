import SwiftUI

class FruitMenuViewModel: ObservableObject {
    let contact = FruitMenuModel()
    @Published var isMenu = false
    @Published var isSettings = false
    @Published var isPlay = false
    @Published var isDayly = false
    @Published var isLevels = false
    @Published var isShop = false
    
    @Published var canGetBonus: Bool = false
    
    init() {
        updateRemainingTime()
        startTimer()
    }
    
    private let key = "lastTransitionDate"
    private let cooldownInterval: TimeInterval = 24 * 60 * 60
    
    @Published var remainingTime: TimeInterval = 0
    
    private var timer: Timer?
    
    func recordTransition() {
        let now = Date()
        UserDefaults.standard.set(now, forKey: key)
        updateRemainingTime()
    }
    
    func canTransition() -> Bool {
        remainingTime <= 0
    }
    
    private func updateRemainingTime() {
        if let lastDate = UserDefaults.standard.object(forKey: key) as? Date {
            let elapsed = Date().timeIntervalSince(lastDate)
            remainingTime = max(cooldownInterval - elapsed, 0)
        } else {
            remainingTime = 0
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateRemainingTime()
        }
    }
    
    deinit {
        timer?.invalidate()
    }
    
    func formattedRemainingTime() -> String {
        let totalSeconds = Int(remainingTime)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        return String(format: "%02d:%02d", hours, minutes)
    }
}
