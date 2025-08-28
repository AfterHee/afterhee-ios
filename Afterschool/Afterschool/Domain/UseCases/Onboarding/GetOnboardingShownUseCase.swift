//
//  GetOnboardingShownUseCase.swift
//  Afterschool
//
//  Created by 임영택 on 8/28/25.
//

import Foundation

struct GetOnboardingShownUseCase {
    let UserDefaultRepository: UserDefaultRepositoryProtocol
    
    init(UserDefaultRepository: UserDefaultRepositoryProtocol) {
        self.UserDefaultRepository = UserDefaultRepository
    }
    
    func execute() -> Bool {
        UserDefaultRepository.load(Bool.self, forKey: .onboardingShown) ?? false
    }
}
