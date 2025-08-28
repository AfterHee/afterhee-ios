//
//  ContentView.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/19/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.diContainer) private var container
    
    var body: some View {
        MainView(deps: container.mainDepsProvider)
    }
}

#Preview {
    ContentView()
}
