//
//  LoadingAndResultViewNavigationBar.swift
//  Afterschool
//
//  Created by 임영택 on 8/26/25.
//

import SwiftUI

struct LoadingAndResultViewNavigationBar: View {
    @Environment(\.dismiss) var dismiss
    
    private let backButtonImageWidth: CGFloat = 15
    private let backButtonImageHeight: CGFloat = 21
    private let navBarHeight: CGFloat = 76
    private let horizontalPadding: CGFloat = 18
    
    var body: some View {
        VStack {
            ZStack {
                HStack { // 백 버튼
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Color.afWhite)
                            .frame(width: backButtonImageWidth, height: backButtonImageHeight)
                    }
                    
                    Spacer()
                }
                .frame(height: navBarHeight)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, horizontalPadding)
            }
            
            Spacer()
        }
    }
}



#Preview {
    ZStack {
        Color.afBlack
            .ignoresSafeArea()
        
        LoadingAndResultViewNavigationBar()
    }
}
