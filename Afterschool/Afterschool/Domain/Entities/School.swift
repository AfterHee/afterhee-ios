//
//  School.swift
//  Afterschool
//
//  Created by SchoolSearchApp UI Integration
//

import Foundation

/// 학교 정보를 담는 엔티티
struct School: Identifiable, Equatable {
    let id: String
    let name: String
    let address: String
    let detailAddress: String
    let adminCode: String
    let sidoCode: String
    let sidoName: String
    
    // MARK: - Computed Properties
    /// 검색 가능한 텍스트 (학교명 + 주소)
    var searchableText: String {
        return "\(name) \(address)"
    }
    
    /// 학교 유형 (초등학교, 중학교, 고등학교)
    var schoolType: String {
        if name.contains("초등학교") {
            return "초등학교"
        } else if name.contains("중학교") {
            return "중학교"
        } else if name.contains("고등학교") {
            return "고등학교"
        } else {
            return "기타"
        }
    }
    
    /// 전체 주소
    var fullAddress: String {
        return "\(address) \(detailAddress)".trimmingCharacters(in: .whitespaces)
    }
}


