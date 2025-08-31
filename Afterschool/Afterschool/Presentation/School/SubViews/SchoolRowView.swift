//
//  SchoolRowView.swift
//  Afterschool
//
//  Created by Sandeul
//

import SwiftUI

/// 학교 정보를 표시하는 행 컴포넌트
/// 검색어와 일치하는 부분을 강조 표시하는 기능 포함
/// 비활성화 상태 지원
/// Afterschool 디자인 시스템에 맞춰 구현
struct SchoolRowView: View {
    // MARK: - Properties
    let school: School
    let searchText: String
    let isDisabled: Bool
    let onTap: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button(action: onTap) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    // 학교명 (검색어 강조 표시 포함)
                    highlightedSchoolName
                    
                    // 학교 주소
                    Text(school.address)
                        .font(.afRegular14)
                        .foregroundColor(isDisabled ? .afGray400 : .afGray700)
                }
                Spacer()
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
        .background(Color.afWhite)
        .frame(maxWidth: .infinity)
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.5 : 1.0)
    }
}

// MARK: - Private Views
private extension SchoolRowView {
    
    /// 검색어 강조 표시가 적용된 학교명 뷰
    @ViewBuilder
    var highlightedSchoolName: some View {
        if searchText.isEmpty {
            // 검색어가 없으면 기본 스타일로 표시
            Text(school.name)
                .font(.afRegular16)
                .foregroundColor(isDisabled ? .afGray400 : .afBlack)
        } else {
            // 검색어가 있으면 강조 표시 적용
            HStack(spacing: 0) {
                ForEach(splitTextBySearchTerm(school.name, searchText: searchText), id: \.self) { textPart in
                    let isHighlighted = textPart.lowercased() == searchText.lowercased()
                    Text(textPart)
                        .font(isHighlighted ? .system(size: 16, weight: .bold) : .afRegular16)
                        .foregroundColor(isDisabled ? .afGray400 : .afBlack)
                }
            }
        }
    }
}

// MARK: - Private Methods
private extension SchoolRowView {
    
    /// 텍스트를 검색어 기준으로 분할하여 강조 표시를 위한 배열 반환
    /// - Parameters:
    ///   - text: 분할할 원본 텍스트
    ///   - searchText: 검색어
    /// - Returns: [검색어 이전 텍스트, 검색어, 검색어 이후 텍스트] 배열
    func splitTextBySearchTerm(_ text: String, searchText: String) -> [String] {
        // 검색어가 비어있으면 원본 텍스트 그대로 반환
        guard !searchText.isEmpty else { 
            return [text] 
        }
        
        let lowercasedText = text.lowercased()
        let lowercasedSearch = searchText.lowercased()
        
        // 검색어가 텍스트에 포함되어 있는지 확인
        guard let searchRange = lowercasedText.range(of: lowercasedSearch) else {
            return [text]
        }
        
        // 검색어 위치에 맞춰 원본 텍스트의 인덱스 계산
        let startIndex = text.index(
            text.startIndex, 
            offsetBy: lowercasedText.distance(from: lowercasedText.startIndex, to: searchRange.lowerBound)
        )
        let endIndex = text.index(
            text.startIndex, 
            offsetBy: lowercasedText.distance(from: lowercasedText.startIndex, to: searchRange.upperBound)
        )
        
        // 텍스트를 3부분으로 분할
        let beforeSearchTerm = String(text[..<startIndex])
        let searchTerm = String(text[startIndex..<endIndex])
        let afterSearchTerm = String(text[endIndex...])
        
        // 빈 문자열은 제외하고 결과 배열 구성
        var result: [String] = []
        
        if !beforeSearchTerm.isEmpty {
            result.append(beforeSearchTerm)
        }
        result.append(searchTerm)
        if !afterSearchTerm.isEmpty {
            result.append(afterSearchTerm)
        }
        return result
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 0) {
        // 활성화된 학교 행
        SchoolRowView(
            school: School(
                id: "1",
                name: "애플디자인고등학교",
                address: "경상북도 포항시 북구",
                detailAddress: "애플로 123",
                adminCode: "G10",
                sidoCode: "47",
                sidoName: "경상북도"
            ),
            searchText: "애플",
            isDisabled: false
        ) {
            print("애플디자인고등학교 버튼 눌림!")
        }
        
        Divider()
            .background(Color.afGray100)
            .padding(.horizontal, 20)
        
        // 비활성화된 학교 행 (현재 선택된 학교)
        SchoolRowView(
            school: School(
                id: "2",
                name: "포항애플중학교",
                address: "경상북도 포항시 북구",
                detailAddress: "애플로 456",
                adminCode: "G10",
                sidoCode: "47",
                sidoName: "경상북도"
            ),
            searchText: "애",
            isDisabled: true
        ) {
            print("포항애플중학교 버튼 눌림!")
        }
        
        Divider()
            .background(Color.afGray100)
            .padding(.horizontal, 20)
        
        // 활성화된 학교 행
        SchoolRowView(
            school: School(
                id: "3",
                name: "애플공업고등학교",
                address: "경상북도 포항시 북구",
                detailAddress: "애플로 789",
                adminCode: "G10",
                sidoCode: "47",
                sidoName: "경상북도"
            ),
            searchText: "",
            isDisabled: false
        ) {
            print("애플공업고등학교 버튼 눌림!")
        }
    }
    .background(Color.afWhite)
    .padding()
}
