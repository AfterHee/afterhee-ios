//
//  RootView.swift
//  Afterschool
//
//  Created by 임영택 on 8/28/25.
//

import SwiftUI

struct RootView: View {
    @Environment(\.diContainer) private var container
    @StateObject private var navigationRouter: NavigationRouter
    
    init(navigationRouter: NavigationRouter) {
        self._navigationRouter = .init(wrappedValue: navigationRouter)
    }
    
    var body: some View {
        NavigationStack(path: $navigationRouter.path) {
            MainView(deps: container.mainDepsProvider)
                .navigationDestination(for: Route.self) { path in
                    NavigationRouteView(path: path)
                }
        }
    }
}

#Preview {
    RootView(navigationRouter: NavigationRouter())
}
