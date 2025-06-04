import SwiftUI

extension Text {
    func Guy(size: CGFloat,
              color: Color = .white,
              colorOutline: Color = Color(red: 255/255, green: 0/255, blue: 209/255),
              width: CGFloat = 0.3) -> some View {
        self.font(.custom("LuckiestGuy-Regular", size: size))
            .foregroundColor(color)
            .outlineText(color: Color(red: 158/255, green: 40/255, blue: 250/255), width: width)
    }
}
