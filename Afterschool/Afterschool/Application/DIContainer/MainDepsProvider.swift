//
//  MainDepsProvider.swift
//  Afterschool
//
//  Created by 임영택 on 8/28/25.
//

import Foundation

final class MainDepsProvider: MainDepsProviding {
    let navigationRouter: NavigationRouter
    
    init(navigationRouter: NavigationRouter) {
        self.navigationRouter = navigationRouter
    }
    
    func getMainViewModel() -> MainViewModel {
        let userDefaultsStorage = UserDefaultsStorage()
        let userDefaultsRepository = UserDefaultsRepository(storage: userDefaultsStorage)
        let mainServerRepository = MainServerRepository()
        let getOnboarindgShownUseCase = GetOnboardingShownUseCase(userDefaultRepository: userDefaultsRepository)

        let getSelectedSchoolUseCase = GetSelectedSchoolUseCase(userDefaultRepository: userDefaultsRepository)
        let getMealUseCase = GetMealsUseCase(serverRepository: mainServerRepository, userDefaultsRepository: userDefaultsRepository)
        return MainViewModel(getOnboarindgShownUseCase: getOnboarindgShownUseCase, getMealUseCase: getMealUseCase, getSelectedSchool: getSelectedSchoolUseCase, navigationRouter: navigationRouter)
    }
}
