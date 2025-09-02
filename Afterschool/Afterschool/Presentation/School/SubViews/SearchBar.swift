//
//  SearchBar.swift
//  Afterschool
//
//  Created by 산들 on 8/28/25.
//

import SwiftUI

// MARK: - NotificationCenter Extension
extension Notification.Name {
    static let dismissKeyboard = Notification.Name("dismissKeyboard")
}

/// 검색바 컴포넌트
struct SearchBar: View {
    @Binding var searchText: String
    let placeholder: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.afBlack)
            
            TextField(placeholder, text: $searchText)
                .font(.afRegular16)
                .foregroundColor(.afBlack)
                .textFieldStyle(PlainTextFieldStyle())
                .focused($isFocused)
            
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
        .frame(height: 44)
        .background(Color.afGray50)
        .cornerRadius(8)
        .onReceive(NotificationCenter.default.publisher(for: .dismissKeyboard)) { _ in
            dismissKeyboard()
        }
    }
    
    /// 키보드를 내리는 메서드
    func dismissKeyboard() {
        isFocused = false
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
