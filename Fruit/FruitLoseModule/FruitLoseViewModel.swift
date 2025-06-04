import SwiftUI

class FruitLoseViewModel: ObservableObject {
    let contact = FruitLoseModel()
    @Published var isMenu = false
    @Published var isGame = false
}
