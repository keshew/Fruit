import SwiftUI
import SpriteKit

struct FruitRulesView: View {
    @StateObject var fruitRulesModel =  FruitRulesViewModel()
    var game: GameData
    var scene: SKScene
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Button(action: {
                            game.isRules = false
                            scene.isPaused = false
                        }) {
                            Image(.back)
                                .resizable()
                                .frame(width: 70, height: 85)
                        }
                        .padding(.leading, 20)
                        .offset(y: -10)
                        
                        Spacer()
                    }
                    
                    VStack {
                        Text("HOW TO PLAY?")
                            .Guy(size: 34)
                            .padding(.top)
                        
                        Image(.settingsBack)
                            .resizable()
                            .overlay {
                                VStack {
                                    Text("There are 2 little Apples battling against each other by trying to control as much fruity matter as possible. Once the fruit gets too big it becomes unstable - the next click on it starts a fruity reaction. The one who caused this explosion gains control of the surrounding orchards. Click on an orchard to gain control of it and place a bit of fruity matter. The other fruits become unstable at the size of 8. Fruits in corner orchards already become unstable when they reach a size of 3. Fruits at the border become unstable at the size of 5.")
                                        .Guy(size: 18)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 30)
                                }
                            }
                            .frame(height: 400)
                            .padding(.horizontal, UIScreen.main.bounds.width > 900 ? 260 : (UIScreen.main.bounds.width > 600 ? 180 : 15))
                            .padding(.top, 20)
                    }
                    .padding(.top, 70)
                }
                .padding(.top)
            }
        }
    }
}

#Preview {
    let gameData = GameData()
    let scene = SKScene()
    FruitRulesView(game: gameData, scene: scene)
}

