//
//  AFFont.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/24/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretendard {
        case extraBold
        case bold
        case semibold
        case medium
        case regular
        case light
        
        var value: String {
            switch self {
            case .extraBold:
                return "Pretendard-ExtraBold"
            case .bold:
                return "Pretendard-Bold"
            case .semibold:
                return "Pretendard-SemiBold"
            case .medium:
                return "Pretendard-Medium"
            case .regular:
                return "Pretendard-Regular"
            case .light:
                return "Pretendard-Light"
            }
        }
    }
    
    static func pretendard(type: Pretendard, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    /// Bold
    static var afBold20: Font {
        return .pretendard(type: .bold, size: 20)
    }
    
    static var afBold16: Font {
        return .pretendard(type: .bold, size: 16)
    }
    
    static var afBold14: Font {
        return .pretendard(type: .bold, size: 14)
    }
    
    /// SemiBold
    static var afSemiBold18: Font {
        return .pretendard(type: .semibold, size: 18)
    }
    
    static var afSemiBold17: Font {
        return .pretendard(type: .semibold, size: 17)
    }
    
    /// Medium
    static var afMedium16: Font {
        return .pretendard(type: .medium, size: 16)
    }
    
    static var afMedium14: Font {
        return .pretendard(type: .medium, size: 14)
    }
    
    /// Regular
    static var afRegular16: Font {
        return .pretendard(type: .regular, size: 16)
    }
    
    static var afRegular14: Font {
        return .pretendard(type: .regular, size: 14)
    }
    
    static var afRegular13: Font {
        return .pretendard(type: .regular, size: 13)
    }
}

/// Line Height 적용 View Modifier
struct LineHeight: ViewModifier {
    let fontSize: CGFloat
    let lineHeight: CGFloat
    
    func body(content: Content) -> some View {
        content
            .lineSpacing(fontSize * lineHeight - fontSize)
            .padding(.vertical, (fontSize * lineHeight - fontSize) / 2)
    }
}

extension View {
    func lineHeight(_ lineHeight: CGFloat, fontSize: CGFloat) -> some View {
        self.modifier(LineHeight(fontSize: fontSize, lineHeight: lineHeight))
    }
    
    /// 사용법 :
    // Text("예시 텍스트입니다.")
    //    .font(.afBold20)
    //    .lineHeight(fontSize: 20, lineHeight: 1.2)
}
