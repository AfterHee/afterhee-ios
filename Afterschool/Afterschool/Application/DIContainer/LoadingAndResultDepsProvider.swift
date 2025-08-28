//
//  LoadingAndResultDepsProvider.swift
//  Afterschool
//
//  Created by 임영택 on 8/29/25.
//

import Foundation

final class LoadingAndResultDepsProvider: LoadingAndResultDepsProviding {
    var navigationRouter: NavigationRouter
    
    init(navigationRouter: NavigationRouter) {
        self.navigationRouter = navigationRouter
    }
    
    func getLoadingAndResultViewModel(category: MealCategory, skipMenus: [String]) -> LoadingAndResultViewModel {
        let repository = MainServerRepository()
        let getRecommendationUseCase = GetRecommendationUseCase(repository: repository)
        return LoadingAndResultViewModel(
            category: category,
            skipMenus: skipMenus,
            getRecommendationUseCase: getRecommendationUseCase
        )
    }
}
