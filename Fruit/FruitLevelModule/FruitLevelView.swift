import SwiftUI

struct FruitLevelView: View {
    @StateObject var fruitLevelModel =  FruitLevelViewModel()
    @State var grid = [GridItem(.flexible(), spacing: -20),
                       GridItem(.flexible(), spacing: -20),
                       GridItem(.flexible(), spacing: -20)]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Image(fruitLevelModel.contact.bg[fruitLevelModel.currentIndex])
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
                    
                    Text("LEVELS")
                        .Guy(size: 34)
                    
                    VStack {
                        LazyVGrid(columns: grid) {
                            let itemsPerPage = 12
                            let startIndex = fruitLevelModel.currentIndex * itemsPerPage
                            let endIndex = startIndex + itemsPerPage

                            ForEach(startIndex..<endIndex, id: \.self) { index in
                                if (UserDefaultsManager.defaults.object(forKey: Keys.currentLevel.rawValue) as? Int ?? 1) >= index + 1 {
                                    Button(action: {
                                        fruitLevelModel.isPlay = true
                                        fruitLevelModel.currentLevel = index + 1
                                    }) {
                                        Image(.levelPin)
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                            .overlay {
                                                Text("\(index + 1)")
                                                    .Guy(size: 46)
                                                    .offset(y: 7)
                                            }
                                    }
                                } else {
                                    ZStack {
                                        Image(.levelPin)
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                            .overlay {
                                                Text("\(index + 1)")
                                                    .Guy(size: 46)
                                                    .offset(y: 7)
                                            }
                                            .blur(radius: 5)
                                        
                                        Image(.locked)
                                            .resizable()
                                            .frame(width: 50, height: 60)
                                    }
                                }
                              
                            }
                        }
                    }
                    .padding(.top)
                    
                    Text(fruitLevelModel.contact.difficulty[fruitLevelModel.currentIndex])
                        .Guy(size: 34)
                        .padding(.top, 30)
                    
                    Text("SWIPE LEFT\\RIGHT to next\\prev page")
                        .Guy(size: 20)
                        .padding(.top, 60)
                }
            }
        }
        .fullScreenCover(isPresented: $fruitLevelModel.isPlay, content: {
            FruitGameView(level: fruitLevelModel.currentLevel)
        })
        .gesture(
            DragGesture()
                .onEnded { value in
                    let horizontalAmount = value.translation.width
                    if horizontalAmount < -50 {
                        if fruitLevelModel.currentIndex < fruitLevelModel.contact.bg.count - 1 {
                            fruitLevelModel.currentIndex += 1
                        }
                        
                    } else if horizontalAmount > 50 {
                        if fruitLevelModel.currentIndex > 0 {
                            fruitLevelModel.currentIndex -= 1
                        }
                    }
                }
        )
    }
}

#Preview {
    FruitLevelView()
}

