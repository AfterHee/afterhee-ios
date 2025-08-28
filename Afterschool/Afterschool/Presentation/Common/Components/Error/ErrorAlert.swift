//
//  ErrorAlert.swift
//  Afterschool
//
//  Created by 임영택 on 8/28/25.
//

import SwiftUI

struct ErrorAlert: View {
    // Constraints
    let outerRadius: CGFloat = 12
    let alertSize: CGSize = .init(width: 321, height: 233)
    let emojiSize: CGFloat = 45
    let emojiTopPadding: CGFloat = 40
    let emojiBottomPadding: CGFloat = 24
    
    var body: some View {
        RoundedRectangle(cornerRadius: outerRadius, style: .circular)
            .foregroundStyle(Color.afWhite)
            .frame(width: alertSize.width, height: alertSize.height)
            .overlay {
                VStack(spacing: 0) {
                    Image(.alertEmoji)
                        .resizable()
                        .frame(width: emojiSize, height: emojiSize)
                        .padding(.top, emojiTopPadding)
                        .padding(.bottom, emojiBottomPadding)
                    
                    ErrorTitle(title: "추천 메뉴를 불러오지 못했어요.")
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
                        Rectangle()
                            .foregroundStyle(Color.afGray100)
                            .frame(maxWidth: .infinity, maxHeight: 1)
                        
                        ErrorAlertOKButton(title: "다시 시도하기") {
                            //
                        }
                    }
                }
            }
    }
}

#Preview {
    ZStack {
        Color.black
        
        ErrorAlert()
    }
}
