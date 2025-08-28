//
//  ErrorSearchView.swift
//  Afterschool
//
//  Created by 산들 on 8/28/25.
//

import SwiftUI

/// 학교 검색 에러 상태를 표시하는 컴포넌트
struct ErrorSearchView: View {
    let searchErrorMessage: String
    let retrySearchAction: () -> Void
    
    init(_ searchErrorMessage: String = "학교 정보를 불러오지 못했어요.", retrySearchAction: @escaping () -> Void) {
        self.searchErrorMessage = searchErrorMessage
        self.retrySearchAction = retrySearchAction
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(searchErrorMessage)
                .font(.afMedium16)
                .foregroundColor(.afGray400)
                .multilineTextAlignment(.center)
            
            Button(action: retrySearchAction) {
                Text("다시 시도하기")
                    .font(.afMedium14)
                    .foregroundColor(.afGray400)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.afGray50)
                    .cornerRadius(12)
            }
        }
    }
}

#Preview {
    ErrorSearchView {
        print("Retry search tapped")
    }
}
