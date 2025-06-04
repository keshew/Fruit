import SwiftUI

class FruitSettingsViewModel: ObservableObject {
    let contact = FruitSettingsModel()
    @Published var musicCount = 6
    @Published var soundCount = 6

    func saveSettingsToUserDefaults() {
        UserDefaults.standard.set(musicCount, forKey: "musicCount")
        UserDefaults.standard.set(soundCount, forKey: "soundCount")
    }

    func loadSettingsFromUserDefaults() {
        musicCount = UserDefaults.standard.integer(forKey: "musicCount")
        if musicCount == 0 {
            musicCount = 6
        }

        soundCount = UserDefaults.standard.integer(forKey: "soundCount")
        if soundCount == 0 {
            soundCount = 6
        }
    }

    init() {
        loadSettingsFromUserDefaults()
    }
}
