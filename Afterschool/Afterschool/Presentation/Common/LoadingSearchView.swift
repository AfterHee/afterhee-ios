//
//  LoadingSearchView.swift
//  Afterschool
//
//  Created by SchoolSearchApp UI Integration
//

import SwiftUI

/// 검색 중 로딩 상태를 표시하는 뷰
struct LoadingSearchView: View {
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.2)
                .progressViewStyle(CircularProgressViewStyle(tint: .afGray400))
            
            Text("학교 정보를 불러오는 중...")
                .font(.afMedium16)
                .foregroundColor(.afGray700)
        }
    }
}

// MARK: - Preview
#Preview {
    LoadingSearchView()
}
