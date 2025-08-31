//
//  NavigationRouteView.swift
//  Afterschool
//
//  Created by 임영택 on 8/28/25.
//

import SwiftUI

struct NavigationRouteView: View {
    @Environment(\.diContainer) private var container
    let path: Route
    
    var body: some View {
        switch path {
        case .schoolSetting(let isOnboarding):
            if isOnboarding {
                SchoolRegisterView(deps: container.schoolSearchDepsProvider)
            } else {
                SchoolSearchChangeView(deps: container.schoolSearchDepsProvider)
            }
        case .result(let category, let skipMenus):
            LoadingAndResultView(deps: container.loadingAndResultDepsProvider, category: category, skipMenus: skipMenus)
        }
    }
}

#Preview {
    NavigationRouteView(path: .schoolSetting(isOnboarding: true))
}
