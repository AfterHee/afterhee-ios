//
//  LoadingAndResultDepsProviding.swift
//  Afterschool
//
//  Created by 임영택 on 8/29/25.
//

import Foundation

protocol LoadingAndResultDepsProviding {
    var navigationRouter: NavigationRouter { get }
    func getLoadingAndResultViewModel(category: MealCategory, skipMenus: [String]) -> LoadingAndResultViewModel
}
