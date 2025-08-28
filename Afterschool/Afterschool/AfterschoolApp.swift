//
//  AfterschoolApp.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/19/25.
//

import SwiftUI

@main
struct AfterschoolApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.diContainer, DIContainer())
        }
    }
}
