//
//  GetOnboardingShownUseCase.swift
//  Afterschool
//
//  Created by 임영택 on 8/28/25.
//

import Foundation

struct GetOnboardingShownUseCase {
    let userDefaultRepository: UserDefaultsRepositoryProtocol
    
    init(userDefaultRepository: UserDefaultsRepositoryProtocol) {
        self.userDefaultRepository = userDefaultRepository
    }
    
    func execute() -> Bool {
        userDefaultRepository.load(Bool.self, forKey: .onboardingShown) ?? false
    }
}
