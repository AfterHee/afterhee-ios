//
//  DIContainer.swift
//  Afterschool
//
//  Created by 임영택 on 8/28/25.
//

import Foundation

final class DIContainer {
    lazy var navigationRouter: NavigationRouter = NavigationRouter()
    lazy var mainDepsProvider: MainDepsProviding = MainDepsProvider(navigationRouter: navigationRouter)
}
