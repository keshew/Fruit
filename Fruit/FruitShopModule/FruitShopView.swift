import SwiftUI

struct FruitShopView: View {
    @StateObject var fruitShopModel =  FruitShopViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Image(.bg)
                .resizable()
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(.back)
                                .resizable()
                                .frame(width: 65, height: 80)
                        }
                        .padding(.leading)
                        
                        Spacer()
                    }
                    
                    Text("SHOP")
                        .Guy(size: 34)
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
                    .padding(.top, 20)
                    
                    Image(.settingsBack)
                        .resizable()
                        .overlay {
                            VStack(spacing: 25) {
                                Text(fruitShopModel.contact.name[fruitShopModel.currentIndex])
                                    .Guy(size: 28)
                                
                                HStack(spacing: 30) {
                                    Image(fruitShopModel.contact.image[fruitShopModel.currentIndex])
                                        .resizable()
                                        .frame(width: 90, height: 80)
                                    
                                    Text("X 3")
                                        .Guy(size: 34)
                                }
                                
                                Text(fruitShopModel.contact.desc[fruitShopModel.currentIndex])
                                    .Guy(size: 18)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 50)
                                
                                Spacer()
                            }
                            .padding(.top, 30)
                            .overlay {
                                Button(action: {
                                    if fruitShopModel.currentIndex == 0 {
                                        UserDefaultsManager().buyBonus(key: Keys.moveBonus.rawValue)
                                    } else {
                                        UserDefaultsManager().buyBonus(key: Keys.pointsBonus.rawValue)
                                    }
                                    fruitShopModel.again = 1
                                }) {
                                    Image(.backBtn)
                                        .resizable()
                                        .frame(width: 170, height: 170)
                                        .overlay {
                                            VStack {
                                                Text("BUY")
                                                    .Guy(size: 24)
                                                    .offset(y: 6)
                                                
                                                HStack {
                                                    Text("30")
                                                        .Guy(size: 20)
                                                        .offset(y: 3)
                                                    
                                                    Image(.coin)
                                                        .resizable()
                                                        .frame(width: 20, height: 20)
                                                }
                                            }
                                        }
                                }
                                .offset(y: 200)
                            }
                        }
                        .frame(height: 420)
                        .padding(.horizontal, 20)
                        .padding(.top, 40)
                    
                    Text("SWIPE LEFT\\RIGHT to next\\prev page")
                        .Guy(size: 20)
                        .padding(.top, 120)
                }
            }
        }
        .gesture(DragGesture()
            .onEnded { value in
                let horizontalAmount = value.translation.width
                if horizontalAmount < -50 {
                    if fruitShopModel.currentIndex <= 0 {
                        fruitShopModel.currentIndex += 1
                    }
                } else if horizontalAmount > 50 {
                    if fruitShopModel.currentIndex >= 1 {
                        fruitShopModel.currentIndex -= 1
                    }
                }
            }
        )
    }
}

#Preview {
    FruitShopView()
}

