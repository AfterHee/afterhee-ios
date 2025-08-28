//
//  LoadingSearchView.swift
//  Afterschool
//
//  Created by 산들 on 8/28/25.
//

import SwiftUI

/// 학교 검색 로딩 상태를 표시하는 컴포넌트
struct LoadingSearchView: View {
    let searchMessage: String
    
    init(_ searchMessage: String = "학교 정보 불러오는 중...") {
        self.searchMessage = searchMessage
    }
    
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(1.2)
            
            Text(searchMessage)
                .font(.afRegular16)
                .foregroundColor(.afGray400)
        }
    }
}

#Preview {
    LoadingSearchView()
}
