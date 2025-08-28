//
//  NavigationRouter.swift
//  Afterschool
//
//  Created by 임영택 on 8/28/25.
//

import SwiftUI

final class NavigationRouter: ObservableObject {
    @Published var path = NavigationPath()

    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }

    func reset() {
        path = NavigationPath()
    }
}
