//
//  SearchBar.swift
//  Afterschool
//
//  Created by 산들 on 8/28/25.
//

import SwiftUI

/// 검색바 컴포넌트
struct SearchBar: View {
    @Binding var searchText: String
    let placeholder: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.afBlack)
            
            TextField(placeholder, text: $searchText)
                .font(.afRegular16)
                .foregroundColor(.afBlack)
                .textFieldStyle(PlainTextFieldStyle())
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.afGray400)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color.afGray50)
        .cornerRadius(8)
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 20) {
        SearchBar(searchText: .constant(""), placeholder: "학교명을 입력하세요")
        SearchBar(searchText: .constant("애플"), placeholder: "학교명을 입력하세요")
    }
    .padding()
}
