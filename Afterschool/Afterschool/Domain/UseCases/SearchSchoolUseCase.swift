//
//  SearchSchoolUseCase.swift
//  Afterschool
//
//  Created by 산들 on 8/28/25.
//

import Foundation

final class SearchSchoolUseCase {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func execute(keyword: String) async throws -> [School] {
        return try await networkService.fetchSchools(keyword: keyword)
    }
}
