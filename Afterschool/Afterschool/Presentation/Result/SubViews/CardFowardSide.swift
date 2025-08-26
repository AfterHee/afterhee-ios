//
//  CardFowardSide.swift
//  Afterschool
//
//  Created by 임영택 on 8/26/25.
//

import SwiftUI

struct CardFowardSide: View {
    // MARK: - Properties
    let recommendation: String
    
    // MARK: - Constraints
    private let cardTitleFont = Font.pretendard(type: .bold, size: 30)
    private let cardTitleFontSize: CGFloat = 30
    private let titleBottomPadding: CGFloat = 16
    private let horizontalPadding: CGFloat = 16
    private let recommendationLineHeight: CGFloat = 1.3
    
    var body: some View {
        VStack(spacing: 0) {
            Text("그래! 오늘은")
                .font(.afBold16)
                .padding(.bottom, titleBottomPadding)
            
            Text(recommendation)
                .font(cardTitleFont)
                .lineHeight(recommendationLineHeight, fontSize: cardTitleFontSize)
                
        }
        .padding(.horizontal, horizontalPadding)
        .foregroundStyle(Color.afWhite)
    }
}
