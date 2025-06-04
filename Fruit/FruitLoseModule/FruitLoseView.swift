import SwiftUI
import SpriteKit

struct FruitLoseView: View {
    @StateObject var fruitLoseModel =  FruitLoseViewModel()
    var game: GameData
    var scene: SKScene
    var level: Int
    var body: some View {
        ZStack {
            Color.black.opacity(0.7).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Button(action: {
                            fruitLoseModel.isMenu = true
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
                        Text("GAME OVER")
                            .Guy(size: 34)
                            .padding(.top)
                        
                        Image(.settingsBack)
                            .resizable()
                            .overlay {
                                VStack(spacing: 50) {
                                    Text("Defeat is just a stepping stone to success. Learn from this experience, regroup, and come back stronger. Your next victory awaits!")
                                        .Guy(size: 24)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 30)
                                    
                                    VStack(spacing: -10) {
                                        HStack(spacing: 40) {
                                            HStack {
                                                Text("-30")
                                                    .Guy(size: 44)
                                                
                                                Image(.coin)
                                                    .resizable()
                                                    .frame(width: 60, height: 60)
                                            }
                                            
                                            HStack {
                                                Text("-1")
                                                    .Guy(size: 44)
                                                
                                                Image(.life)
                                                    .resizable()
                                                    .frame(width: 65, height: 60)
                                            }
                                        }
                                        
                                        HStack(spacing: 40) {
                                            Button(action: {
                                                fruitLoseModel.isMenu = true
                                            }) {
                                                Image(.backBtn)
                                                    .resizable()
                                                    .frame(width: 170, height: 170)
                                                    .overlay {
                                                        VStack {
                                                            Text("MENU")
                                                                .Guy(size: 22)
                                                                .offset(y: 3)
                                                        }
                                                    }
                                            }
                                            
                                            Button(action: {
                                                fruitLoseModel.isGame = true
                                            }) {
                                                Image(.backBtn)
                                                    .resizable()
                                                    .frame(width: 170, height: 170)
                                                    .overlay {
                                                        VStack {
                                                            Text("RETRY")
                                                                .Guy(size: 22)
                                                                .offset(y: 4)
                                                        }
                                                    }
                                            }
                                        }
                                        
                                    }
                                }
                                .offset(y: 80)
                            }
                            .frame(height: 400)
                            .padding(.horizontal)
                            .padding(.top, 20)
                    }
                    .padding(.top, 70)
                }
                .padding(.top)
            }
        }
        .fullScreenCover(isPresented: $fruitLoseModel.isMenu) {
            FruitMenuView()
        }
        
        .fullScreenCover(isPresented: $fruitLoseModel.isGame) {
            FruitGameView(level: level)
        }
    }
}

#Preview {
    let game = GameData()
    let scene = SKScene()
    FruitLoseView(game: game, scene: scene, level: 1)
}

