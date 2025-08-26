//
//  LoadingAndResultView.swift
//  Afterschool
//
//  Created by 임영택 on 8/25/25.
//

import SwiftUI

struct LoadingAndResultView: View {
    private let backgroundColor = Color(hex: "#545454")
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            VStack {
                LoadingAndResultTitleLabel()
                    .padding(.top, 80)
                    .padding(.bottom, 102)
                
                Image(.loadingCard)
                
                Spacer()
                
                PrimaryButton(type: .retry) {
                    //
                }
                .primaryButtonDefaultFrame()
                .padding(.horizontal, 16)
            }
        }
    }
}



#Preview {
    LoadingAndResultView()
}
