//
//  School.swift
//  Afterschool
//
//  Created by SchoolSearchApp UI Integration
//

import Foundation

/// 학교 정보를 담는 엔티티
/// TODO: Domain/Entities로 이동 필요
struct School: Identifiable, Equatable {
    let id: String
    let name: String
    let address: String
    
    init(id: String, name: String, address: String) {
        self.id = id
        self.name = name
        self.address = address
    }
}

// MARK: - Mock Data
extension School {
    static let mockSchools = [
        School(id: "1", name: "애플디자인고등학교", address: "경상북도 포항시 북구"),
        School(id: "2", name: "포항애플중학교", address: "경상북도 포항시 북구"),
        School(id: "3", name: "애플공업고등학교", address: "경상북도 포항시 북구"),
        School(id: "4", name: "포항애플고등학교", address: "경상북도 포항시 북구"),
        School(id: "5", name: "애플초등학교", address: "경상북도 포항시 북구")
    ]
}
