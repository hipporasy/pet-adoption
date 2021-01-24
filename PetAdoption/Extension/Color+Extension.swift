//
//  Color+Extension.swift
//  PetAdoption
//
//  Created by Marasy Phi on 17/1/21.
//

import SwiftUI

extension Color {
    
    static let primaryColor = Color.init(hex: 0x6852A5)
    static let primaryDark = Color.init(hex: 0x9B8ACA)
    static let primaryLight = Color.init(hex: 0xF6F4F9)
    static let primaryBackground = Color.white
    static let secondaryColor = Color.init(hex: 0xD3F4E5)
    static let accent = Color.init(hex: 0x9D9BA5)
    static let secondaryDark = Color.init(hex: 0x408063)
    static let lightText = Color.init(hex: 0xF6F4F9)
    static let darkText = Color.init(hex: 0x3C3C43)
    static let primaryYellow = Color.init(hex: 0xF4A325)
    static let secondaryYellow = Color.init(hex: 0xFCC064).opacity(0.16)
    static let lightGrey = Color.init(hex: 0xEFEFF0)
    
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
    var uiColor: UIColor {
        return .init(self)
    }
    
}
