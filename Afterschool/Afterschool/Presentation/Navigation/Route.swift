//
//  Route.swift
//  Afterschool
//
//  Created by 임영택 on 8/28/25.
//

import Foundation

enum Route: Hashable {
    case schoolSetting(isOnboarding: Bool)
    case result(category: MealCategory, skipMenus: [String])
}
