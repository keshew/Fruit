import SwiftUI

class FruitSettingsViewModel: ObservableObject {
    let contact = FruitSettingsModel()
    @Published var musicCount = 6
    @Published var soundCount = 6

}
