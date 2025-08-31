//
//  SchoolSearchDepsProvider.swift
//  Afterschool
//
//  Created by 임영택 on 8/29/25.
//

import Foundation

final class SchoolSearchDepsProvider: SchoolSearchDepsProviding {
    let navigationRouter: NavigationRouter
    
    init(navigationRouter: NavigationRouter) {
        self.navigationRouter = navigationRouter
    }
    
    func getSchoolSearchViewModel() -> SchoolSearchViewModel {
        let mainServerRepository = MainServerRepository()
        let getSchoolUseCase = GetSchoolUseCase(repository: mainServerRepository)
        
        let userDefaultsStorage = UserDefaultsStorage()
        let userDefaultsRepository = UserDefaultsRepository(storage: userDefaultsStorage)
        let setSelectedSchoolUseCase = SetSelectedSchoolUseCase(userDefaultRepository: userDefaultsRepository)
        let getSelectedSchoolUseCase = GetSelectedSchoolUseCase(userDefaultRepository: userDefaultsRepository)
        
        return SchoolSearchViewModel(
            navigationRouter: navigationRouter,
            getSchoolUseCase: getSchoolUseCase,
            setSelectedSchoolUseCase: setSelectedSchoolUseCase,
            getSelectedSchoolUseCase: getSelectedSchoolUseCase
        )
    }
}
