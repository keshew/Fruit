import SwiftUI

struct FruitMenuView: View {
    @StateObject var fruitMenuModel =  FruitMenuViewModel()

    var body: some View {
        ZStack {
            Image(.bg)
                .resizable()
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Button(action: {
                            fruitMenuModel.isSettings = true
                        }) {
                            Image(.settings)
                                .resizable()
                                .frame(width: 80, height: 80)
                        }
                        .padding(.leading)
                        
                        Spacer()
                    }
                    
                    VStack {
                        Text("Fruit Commotion")
                            .Guy(size: 34)
                        
                        Image(.fruitMenu)
                            .resizable()
                            .frame(width: 200, height: 150)
                    }
                    .padding(.top, 30)
                    
                    HStack {
                        Image(.backCoin)
                            .resizable()
                            .frame(width: 160, height: 60)
                            .overlay {
                                HStack(spacing: 20) {
                                    Image(.coin)
                                        .resizable()
                                        .frame(width: 70, height: 65)
                                    
                                    VStack(spacing: 0){
                                        Text("COINS:")
                                            .Guy(size: 16)
                                        
                                        Text("\(UserDefaultsManager.defaults.object(forKey: Keys.coin.rawValue) as? Int ?? 1)")
                                            .Guy(size: 16)
                                    }
                                    .offset(y: 2)
                                }
                                .offset(x: -30)
                            }
                        
                        Spacer()
                        
                        Image(.backCoin)
                            .resizable()
                            .frame(width: 160, height: 60)
                            .overlay {
                                HStack(spacing: 20) {
                                    Image(.life)
                                        .resizable()
                                        .frame(width: 70, height: 65)
                                    
                                    VStack(spacing: 0){
                                        Text("LIFES:")
                                            .Guy(size: 16)

                                        Text("\(UserDefaultsManager.defaults.object(forKey: Keys.life.rawValue) as? Int ?? 1)")
                                            .Guy(size: 16)
                                    }
                                    .offset(y: 2)
                                }
                                .offset(x: -40)
                            }
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 30)
                    
                    VStack(spacing: 25) {
                        Button(action: {
                            fruitMenuModel.isPlay = true
                        }) {
                            Image(.play)
                                .resizable()
                                .frame(width: 230, height: 65)
                        }
                        
                        Button(action: {
                            fruitMenuModel.isLevels = true
                        }) {
                            Image(.levels)
                                .resizable()
                                .frame(width: 230, height: 65)
                        }
                        
                        Button(action: {
                            fruitMenuModel.isShop = true
                        }) {
                            Image(.shop)
                                .resizable()
                                .frame(width: 230, height: 65)
                        }
                        
                        Button(action: {
                            if fruitMenuModel.canTransition() {
                                fruitMenuModel.recordTransition()
                                fruitMenuModel.isDayly = true
                                UserDefaultsManager().getDaily()
                            }
                        }) {
                            if fruitMenuModel.canTransition() {
                                Image(.daily)
                                    .resizable()
                                    .frame(width: 230, height: 65)
                            } else {
                                Image(.gotReward)
                                    .resizable()
                                    .frame(width: 230, height: 65)
                                    .overlay {
                                        Text(fruitMenuModel.formattedRemainingTime())
                                            .Guy(size: 24)
                                            .offset(x: 8, y: 5)
                                    }
                            }
                        }
                    }
                    .padding(.top, 60)
                }
            }
            
            if fruitMenuModel.isDayly {
                FruitDailyView(isShow: $fruitMenuModel.isDayly)
                    .ignoresSafeArea()
            }
        }
        .fullScreenCover(isPresented: $fruitMenuModel.isSettings) {
            FruitSettingsView()
        }
        .fullScreenCover(isPresented: $fruitMenuModel.isPlay) {
            FruitGameView(level: UserDefaultsManager.defaults.object(forKey: Keys.currentLevel.rawValue) as? Int ?? 1)
        }
        .fullScreenCover(isPresented: $fruitMenuModel.isLevels) {
            FruitLevelView()
        }
        .fullScreenCover(isPresented: $fruitMenuModel.isShop) {
            FruitShopView()
        }
    }
}

#Preview {
    FruitMenuView()
}

