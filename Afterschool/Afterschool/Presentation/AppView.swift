//
//  AppView.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/19/25.
//

import SwiftUI

struct AppView: View {
    @Environment(\.diContainer) private var container
    
    var body: some View {
        RootView(navigationRouter: container.navigationRouter)
    }
}

#Preview {
    AppView()
}
