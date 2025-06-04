import SwiftUI

class FruitGameViewModel: ObservableObject {
    let contact = FruitGameModel()

    func createGameScene(gameData: GameData, level: Int) -> GameSpriteKit {
        let scene = GameSpriteKit(level: level)
        scene.game  = gameData
        return scene
    }
}
