//
//  SearchBar.swift
//  Afterschool
//
//  Created by SchoolSearchApp UI Integration
//

import SwiftUI

/// 학교 검색을 위한 검색바 컴포넌트
/// Afterschool 디자인 시스템에 맞춰 구현
struct SearchBar: View {
    // MARK: - Properties
    @Binding var text: String
    let placeholder: String
    let onSearch: () -> Void
    let onBack: () -> Void
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 12) {
            // 뒤로가기 버튼
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.afBlack)
            }
            
            // 검색 입력 필드
            HStack(spacing: 8) {
                // 돋보기 아이콘
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.afGray400)
                    .font(.system(size: 16, weight: .medium))
                
                // 텍스트 입력 필드
                TextField(placeholder, text: $text)
                    .font(.afRegular16)
                    .foregroundColor(.afBlack)
                    .onSubmit {
                        onSearch()
                    }
                
                // 검색어 삭제 버튼
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.afGray400)
                            .font(.system(size: 16))
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.afGray50)
            .cornerRadius(8)
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 20) {
        // 빈 검색바
        SearchBar(
            text: .constant(""), 
            placeholder: "학교 검색",
            onSearch: { print("Search tapped") },
            onBack: { print("Back tapped") }
        )
        
        // 검색어가 있는 검색바
        SearchBar(
            text: .constant("애플"), 
            placeholder: "학교 검색",
            onSearch: { print("Search tapped") },
            onBack: { print("Back tapped") }
        )
    }
    .padding()
}
