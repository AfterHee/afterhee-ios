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
    
    func execute() -> School? {
        userDefaultRepository.load(School.self, forKey: .selectedSchool)
    }
}
