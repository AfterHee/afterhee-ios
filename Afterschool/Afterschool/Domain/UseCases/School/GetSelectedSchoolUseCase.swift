//
//  GetSelectedSchoolUseCase.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/28/25.
//

import Foundation

struct GetSelectedSchoolUseCase {
    let userDefaultRepository: UserDefaultsRepositoryProtocol
    
    init(userDefaultRepository: UserDefaultsRepositoryProtocol) {
        self.userDefaultRepository = userDefaultRepository
    }
    
    func execute() -> SchoolSelection? {
        userDefaultRepository.load(SchoolSelection.self, forKey: .selectedSchool)
    }
}
