//
//  SetOnboardingShownUseCase.swift
//  Afterschool
//
//  Created by 임영택 on 8/28/25.
//

import Foundation

struct SetOnboardingShownUseCase {
    let UserDefaultRepository: UserDefaultRepositoryProtocol
    
    init(UserDefaultRepository: UserDefaultRepositoryProtocol) {
        self.UserDefaultRepository = UserDefaultRepository
    }
    
    func execute(value: Bool) throws {
        do {
            try UserDefaultRepository.save(value, forKey: .onboardingShown)
        } catch {
            throw DomainError.dataLayerError(cause: error)
        }
    }
}
