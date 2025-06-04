import SwiftUI

class FruitLoadingViewModel: ObservableObject {
    let contact = FruitLoadingModel()
    @Published var width: CGFloat = 0
    @Published var isAnimationDone = false
    
    func increaseWidth() {
        if width <= 290 {
            withAnimation(.linear(duration: 0.1)) {
                width += 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.increaseWidth()
            }
        } else {
            isAnimationDone = true
        }
    }

}
