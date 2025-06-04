import SwiftUI
import SpriteKit

struct FruitPauseView: View {
    @StateObject var fruitPauseModel =  FruitPauseViewModel()
    var game: GameData
    var scene: SKScene
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Button(action: {
                            game.isPause = false
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
                        Text("PAUSE")
                            .Guy(size: 34)
                            .padding(.top)
                        
                        Image(.settingsBack)
                            .resizable()
                            .overlay {
                                VStack {
                                    Text("Whether you're catching your breath or planning your next move, use this time wisely. The adventure awaits your return, so when you're ready, dive back in and continue your quest with renewed vigor and determination. The world of possibilities is just a click away!")
                                        .Guy(size: 25)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 30)
                                        .overlay {
                                            VStack {
                                                Spacer()
                                                
                                                HStack(spacing: 40) {
                                                    Button(action: {
                                                        fruitPauseModel.isMenu = true
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
                                                        game.isPause = false
                                                        scene.isPaused = false
                                                    }) {
                                                        Image(.backBtn)
                                                            .resizable()
                                                            .frame(width: 170, height: 170)
                                                            .overlay {
                                                                VStack {
                                                                    Text("CONTINUE")
                                                                        .Guy(size: 22)
                                                                        .offset(y: 4)
                                                                }
                                                            }
                                                    }
                                                }
                                                .offset(y: 150)
                                            }
                                        }
                                }
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
        .fullScreenCover(isPresented: $fruitPauseModel.isMenu) {
            FruitMenuView()
        }
    }
}

#Preview {
    let gameData = GameData()
    let scene = SKScene()
    FruitPauseView(game: gameData, scene: scene)
}
