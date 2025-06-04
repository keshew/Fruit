import SwiftUI

@main
struct FruitApp: App {
    var body: some Scene {
        WindowGroup {
            FruitLoadingView()
                .onAppear() {
                    UserDefaultsManager().firstLaunch()
                }
        }
    }
}
