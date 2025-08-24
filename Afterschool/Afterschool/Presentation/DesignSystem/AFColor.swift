//
//  AFColor.swift
//  Afterschool
//
//  Created by 산들 on 8/24/25.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6: // RGB (without alpha)
            (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 1) // Default to white in case of an error
        }
        self.init(
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255
        )
    }
    
    func toHex() -> String? {
        let uiColor = UIColor(self)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        guard uiColor.getRed(&r, green: &g, blue: &b, alpha: &a) else {
            return nil
        }
        
        let rgb: Int = (Int)(r * 255) << 16 |
        (Int)(g * 255) << 8 |
        (Int)(b * 255) << 0
        
        return String(format: "%06X", rgb)
    }
    
    // 16진수 색상코드 가져와서 커스텀 컬러 지정
    static let afPrimary = Color(hex: "#FE5936")
    static let afPrimaryLighten = Color(hex: "#FFDED7")
    static let afPrimaryDarken = Color(hex: "#E55031")
    static let afBlack = Color(hex: "#000000")
    static let afgray900 = Color(hex: "#111111")
    static let afgray700 = Color(hex: "#434343")
    static let afgray600 = Color(hex: "#515151")
    static let afgray400 = Color(hex: "#8f8f8f")
    static let afgray200 = Color(hex: "#AAB0B3")
    static let afgray100 = Color(hex: "#E0E2E4")
    static let afgray50 = Color(hex: "#F3F5F7")
    static let afwhite = Color(hex: "#ffffff")
}
