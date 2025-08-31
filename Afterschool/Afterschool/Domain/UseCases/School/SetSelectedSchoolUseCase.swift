//
//  SetSelectedSchoolUseCase.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/28/25.
//

import Foundation

struct SetSelectedSchoolUseCase {
    let userDefaultRepository: UserDefaultsRepositoryProtocol
    
    init(userDefaultRepository: UserDefaultsRepositoryProtocol) {
        self.userDefaultRepository = userDefaultRepository
    }
    
    func execute(school: School) throws {
        do {
            try userDefaultRepository.save(school, forKey: .selectedSchool)
        } catch {
            throw DomainError.dataLayerError(cause: error)
        }
    }
}
