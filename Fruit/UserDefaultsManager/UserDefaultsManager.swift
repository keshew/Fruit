import SwiftUI

enum Keys: String {
    case moveBonus = "timeBonus"
    case pointsBonus = "lifeBonus"
    case currentLevel = "currentLevel"
    case coin = "coin"
    case life = "life"
    case backgroundVolume = "backgroundVolume"
    case soundEffectVolume = "soundEffectVolume"
    case isSoundEnabled = "isSoundEnabled"
    case isMusicEnabled = "isMusicEnabled"
    case selectedPerson = "selectedPerson"
}

class UserDefaultsManager: ObservableObject {
    static let defaults = UserDefaults.standard
    
    func firstLaunch() {
        if UserDefaultsManager.defaults.object(forKey: Keys.currentLevel.rawValue) == nil {
            UserDefaultsManager.defaults.set(1000,  forKey: Keys.coin.rawValue)
            UserDefaultsManager.defaults.set(5,  forKey: Keys.life.rawValue)
            UserDefaultsManager.defaults.set(5,  forKey: Keys.moveBonus.rawValue)
            UserDefaultsManager.defaults.set(5,  forKey: Keys.pointsBonus.rawValue)
            UserDefaultsManager.defaults.set(1,  forKey: Keys.currentLevel.rawValue)
            UserDefaultsManager.defaults.set(0.5, forKey: Keys.backgroundVolume.rawValue)
            UserDefaultsManager.defaults.set(0.5, forKey: Keys.soundEffectVolume.rawValue)
        }
    }

    func loseLevel() {
        let currentLife = UserDefaultsManager.defaults.object(forKey: Keys.life.rawValue) as? Int ?? 1
        let coin = UserDefaultsManager.defaults.object(forKey: Keys.coin.rawValue) as? Int ?? 1
        if coin >= 30 {
            UserDefaultsManager.defaults.set(coin - 30, forKey: Keys.coin.rawValue)
        }
        
        if currentLife >= 2 {
            UserDefaultsManager.defaults.set(currentLife - 1, forKey: Keys.life.rawValue)
        }
    }
    
    func buyLife() {
        let currentLife = UserDefaultsManager.defaults.object(forKey: Keys.life.rawValue) as? Int ?? 1
        let coin = UserDefaultsManager.defaults.object(forKey: Keys.coin.rawValue) as? Int ?? 1
        if coin >= 30 {
            UserDefaultsManager.defaults.set(coin - 30, forKey: Keys.coin.rawValue)
            UserDefaultsManager.defaults.set(currentLife + 1, forKey: Keys.life.rawValue)
        }
    }
    
    func increaseLevel() {
        let currentLevel = UserDefaultsManager.defaults.object(forKey: Keys.currentLevel.rawValue) as? Int ?? 1
        let currentLife = UserDefaultsManager.defaults.object(forKey: Keys.life.rawValue) as? Int ?? 1
        let coin = UserDefaultsManager.defaults.object(forKey: Keys.coin.rawValue) as? Int ?? 1
        
        UserDefaultsManager.defaults.set(currentLife + 1, forKey: Keys.life.rawValue)
        UserDefaultsManager.defaults.set(coin + 30, forKey: Keys.coin.rawValue)
        if currentLevel <= 47 {
            UserDefaultsManager.defaults.set(currentLevel + 1, forKey: Keys.currentLevel.rawValue)
        }
    }

    func buyBonus(key: String) {
        let coin = UserDefaultsManager.defaults.object(forKey: Keys.coin.rawValue) as? Int ?? 1
        let bonus = UserDefaultsManager.defaults.object(forKey: key) as? Int ?? 1
        
        if coin >= 30 {
            UserDefaultsManager.defaults.set(coin - 30, forKey: Keys.coin.rawValue)
            UserDefaultsManager.defaults.set(bonus + 1, forKey: key)
        }
    }
    
    func usePointsBonus() {
        let bonus = UserDefaultsManager.defaults.object(forKey: Keys.pointsBonus.rawValue) as? Int ?? 1
        
        if bonus >= 1 {
            UserDefaultsManager.defaults.set(bonus - 1, forKey: Keys.pointsBonus.rawValue)
        }
    }
    
    func useMoveBonus() {
        let bonus = UserDefaultsManager.defaults.object(forKey: Keys.moveBonus.rawValue) as? Int ?? 1
        
        if bonus >= 1 {
            UserDefaultsManager.defaults.set(bonus - 1, forKey: Keys.moveBonus.rawValue)
        }
    }
    
    func getDaily() {
        let currentLife = UserDefaultsManager.defaults.object(forKey: Keys.life.rawValue) as? Int ?? 1
        let coin = UserDefaultsManager.defaults.object(forKey: Keys.coin.rawValue) as? Int ?? 1
        
        UserDefaultsManager.defaults.set(currentLife + 1, forKey: Keys.life.rawValue)
        UserDefaultsManager.defaults.set(coin + 30, forKey: Keys.coin.rawValue)
    }
}
