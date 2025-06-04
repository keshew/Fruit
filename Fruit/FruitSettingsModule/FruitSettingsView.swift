import SwiftUI

struct FruitSettingsView: View {
    @StateObject var fruitSettingsModel =  FruitSettingsViewModel()
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
                    
                    Text("SETTINGS")
                        .Guy(size: 34)
                        .padding(.top, 30)
                    
                    Image(.settingsBack)
                        .resizable()
                        .overlay {
                            VStack(spacing: 30) {
                                VStack {
                                    Text("MUSIC")
                                        .Guy(size: 30)
                                    
                                    Rectangle()
                                        .fill(LinearGradient(colors: [Color(red: 255/255, green: 2/255, blue: 200/255), Color(red: 128/255, green: 5/255, blue: 153/255)], startPoint: .leading, endPoint: .trailing))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 0)
                                                .stroke(.black)
                                                .overlay {
                                                    HStack(spacing: -15) {
                                                        Button(action: {
                                                            if fruitSettingsModel.musicCount >= 1 {
                                                                fruitSettingsModel.musicCount -= 1
                                                            }
                                                        }) {
                                                            Image(.minus)
                                                                .resizable()
                                                                .frame(width: 50, height: 30)
                                                        }
                                                        .offset(x: -25)
                                                           
                                                        HStack(spacing: -2) {
                                                            ForEach(0..<12, id: \.self) { index in
                                                                if fruitSettingsModel.musicCount <= index {
                                                                    Image(.itemSettings)
                                                                        .resizable()
                                                                        .frame(width: 20, height: 30)
                                                                        .hidden()
                                                                } else {
                                                                    Image(.itemSettings)
                                                                        .resizable()
                                                                        .frame(width: 20, height: 30)
                                                                }
                                                            }
                                                        }
                                                        
                                                        Button(action: {
                                                            if fruitSettingsModel.musicCount <= 11 {
                                                                fruitSettingsModel.musicCount += 1
                                                            }
                                                        }) {
                                                            Image(.plus)
                                                                .resizable()
                                                                .frame(width: 50, height: 30)
                                                        }
                                                        .offset(x: 25)
                                                    }
                                                }
                                        }
                                        .frame(height: 45)
                                        .padding(.horizontal, 50)
                                }
                                
                                VStack {
                                    Text("Sound")
                                        .Guy(size: 30)
                                    
                                    Rectangle()
                                        .fill(LinearGradient(colors: [Color(red: 255/255, green: 2/255, blue: 200/255), Color(red: 128/255, green: 5/255, blue: 153/255)], startPoint: .leading, endPoint: .trailing))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 0)
                                                .stroke(.black)
                                                .overlay {
                                                    HStack(spacing: -15) {
                                                        Button(action: {
                                                            if fruitSettingsModel.soundCount >= 1 {
                                                                fruitSettingsModel.soundCount -= 1
                                                            }
                                                        }) {
                                                            Image(.minus)
                                                                .resizable()
                                                                .frame(width: 50, height: 30)
                                                        }
                                                        .offset(x: -25)
                                                           
                                                        HStack(spacing: -2) {
                                                            ForEach(0..<12, id: \.self) { index in
                                                                if fruitSettingsModel.soundCount <= index {
                                                                    Image(.itemSettings)
                                                                        .resizable()
                                                                        .frame(width: 20, height: 30)
                                                                        .hidden()
                                                                } else {
                                                                    Image(.itemSettings)
                                                                        .resizable()
                                                                        .frame(width: 20, height: 30)
                                                                }
                                                            }
                                                        }
                                                        
                                                        Button(action: {
                                                            if fruitSettingsModel.soundCount <= 11 {
                                                                fruitSettingsModel.soundCount += 1
                                                            }
                                                        }) {
                                                            Image(.plus)
                                                                .resizable()
                                                                .frame(width: 50, height: 30)
                                                        }
                                                        .offset(x: 25)
                                                    }
                                                }
                                        }
                                        .frame(height: 45)
                                        .padding(.horizontal, 50)
                                }
                                
                                Button(action: {
                                    
                                }) {
                                    Image(.backBtn)
                                        .resizable()
                                        .frame(width: 170, height: 170)
                                }
                                .overlay {
                                    Text("SAVE")
                                        .Guy(size: 34)
                                        .offset(y: 6)
                                }
                                .offset(y: -25)
                            }
                            .offset(y: 80)
                        }
                        .frame(height: 350)
                        .padding(.horizontal, 30)
                        .padding(.top, 100)
                }
            }
        }
    }
}

#Preview {
    FruitSettingsView()
}

