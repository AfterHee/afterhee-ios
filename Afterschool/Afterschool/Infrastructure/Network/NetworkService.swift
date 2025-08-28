//
//  NetworkService.swift
//  Afterschool
//
//  Created by 산들 on 8/28/25.
//

import Foundation

/// 네트워크 서비스 프로토콜
protocol NetworkServiceProtocol {
    func fetchSchools(keyword: String) async throws -> [School]
}

/// 네트워크 서비스 구현체
class NetworkService: NetworkServiceProtocol {
    func fetchSchools(keyword: String) async throws -> [School] {
        // TODO: 실제 API 호출 구현
        return School.mockSchools.filter { school in
            school.name.localizedCaseInsensitiveContains(keyword) ||
            school.address.localizedCaseInsensitiveContains(keyword)
        }
    }
}
