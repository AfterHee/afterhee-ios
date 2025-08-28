//
//  NavigationRouteView.swift
//  Afterschool
//
//  Created by 임영택 on 8/28/25.
//

import SwiftUI

struct NavigationRouteView: View {
    let path: Route
    
    var body: some View {
        switch path {
        case .schoolSetting(let isOnboarding):
            Text("schoolSetting")
        case .result(let category, let skipMenus):
            Text("result")
        }
    }
}

#Preview {
    NavigationRouteView(path: .schoolSetting(isOnboarding: true))
}
