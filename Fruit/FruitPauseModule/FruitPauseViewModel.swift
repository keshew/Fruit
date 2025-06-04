import SwiftUI

class FruitPauseViewModel: ObservableObject {
    let contact = FruitPauseModel()
    @Published var isMenu = false
}
