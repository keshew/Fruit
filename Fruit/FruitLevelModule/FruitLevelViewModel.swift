import SwiftUI

class FruitLevelViewModel: ObservableObject {
    let contact = FruitLevelModel()
    @Published var currentIndex = 0
    @Published var isPlay = false
    @Published var currentLevel = 0
}
