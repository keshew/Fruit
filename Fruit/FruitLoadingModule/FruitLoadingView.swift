import SwiftUI

struct FruitLoadingView: View {
    @StateObject var fruitLoadingModel =  FruitLoadingViewModel()

    var body: some View {
        ZStack {
            Image(.bg)
                .resizable()
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack {
                        Text("Fruit Commotion")
                            .Guy(size: 34)
                        
                        Image(.fruitsLoading)
                            .resizable()
                            .frame(width: 300, height: 230)
                    }
                    .padding(.top, 230)
                    
                    VStack {
                        Text("LOADING...")
                            .Guy(size: 34)
                        
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(.white)
                                .cornerRadius(20)
                                .frame(width: 295, height: 25)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(red: 158/255, green: 30/255, blue: 146/255), lineWidth: 5)
                                }
                            
                            RoundedRectangle(cornerRadius: 20)
                                .fill(LinearGradient(colors: [Color(red: 12/255, green: 18/255, blue: 255/255), Color(red: 7/255, green: 254/255, blue: 212/255)], startPoint: .top, endPoint: .bottom))
                                .frame(width: fruitLoadingModel.width, height: 20)
                                .padding(.leading, 2)
                        }
                        .padding(.bottom, 60)
                    }
                    .padding(.top, 200)
                }
            }
        }
        .onAppear {
            fruitLoadingModel.increaseWidth()
        }
        .fullScreenCover(isPresented: $fruitLoadingModel.isAnimationDone) {
            FruitMenuView()
        }
    }
}

#Preview {
    FruitLoadingView()
}

