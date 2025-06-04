import SwiftUI

struct FruitDailyView: View {
    @StateObject var fruitDailyModel =  FruitDailyViewModel()
    @Binding var isShow: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("DAILY REWARD")
                        .Guy(size: 34)
                    
                    Image(.dailyReward)
                        .resizable()
                        .overlay {
                            VStack {
                                Spacer()
                                
                                Button(action: {
                                    isShow = false
                                }) {
                                    Image(.backBtn)
                                        .resizable()
                                        .frame(width: 170, height: 170)
                                }
                                .overlay {
                                    Text("TAKE")
                                        .Guy(size: 34)
                                        .offset(y: 6)
                                }
                                .offset(y: 75)
                            }
                        }
                        .frame(height: 400)
                        .padding(.horizontal)
                        .padding(.top, 50)
                }
                .padding(.top, 180)
            }
        }
    }
}

#Preview {
    FruitDailyView(isShow: .constant(false))
}
