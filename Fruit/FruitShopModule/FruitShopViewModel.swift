import SwiftUI

class FruitShopViewModel: ObservableObject {
    let contact = FruitShopModel()
    @Published var currentIndex = 0
    @Published var again = 0
}
