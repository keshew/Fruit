import SwiftUI

class FruitWinViewModel: ObservableObject {
    let contact = FruitWinModel()
    @Published var isMenu = false
    @Published var isGame = false
}
