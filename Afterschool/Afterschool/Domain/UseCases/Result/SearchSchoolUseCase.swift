//
//  SearchSchoolUseCase.swift
//  Afterschool
//
//  Created by 산들 on 8/28/25.
//

import Foundation

struct GetSchoolUseCase {
    let repository: MainServerRepository
    
    init(repository: MainServerRepository = MainServerRepository()) {
        self.repository = repository
    }
    
    func execute(keyword: String) async throws -> [School] {
        let result = try await repository.getSchools(keyword: keyword)
        
        if let schools = result.data {
            return schools
                .map { toEntity($0) }
        }
        
        return []
    }
    
    func toEntity(_ from: SchoolDTO) -> School {
        return School(
            id: String(from.id),
            name: from.schoolName,
            address: from.roadAddress,
            detailAddress: from.roadDetailAddress,
            adminCode: from.adminStandardCode,
            sidoCode: from.sidoEduOfficeCode,
            sidoName: from.sidoEduOfficeName
        )
    }
}
