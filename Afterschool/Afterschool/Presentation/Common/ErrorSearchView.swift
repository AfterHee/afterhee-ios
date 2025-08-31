//
//  ErrorSearchView.swift
//  Afterschool
//
//  Created by SchoolSearchApp UI Integration
//

import SwiftUI

/// 검색 에러 상태를 표시하는 뷰
struct ErrorSearchView: View {
    let errorMessage: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text(errorMessage)
                .font(.afMedium16)
                .foregroundColor(.afGray400)
                .multilineTextAlignment(.center)
            
            Button(action: retryAction) {
                Text("다시 시도하기")
                    .font(.afMedium14)
                    .foregroundColor(.afGray400)
                    .frame(width: 117, height: 41)
                    .background(Color.afGray50)
                    .cornerRadius(12)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

// MARK: - Preview
#Preview {
    ErrorSearchView(
        errorMessage: "학교 정보를 불러오지 못했어요."
    ) {
        print("Retry tapped")
    }
}
