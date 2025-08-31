//
//  AfterschoolApp.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/19/25.
//

import SwiftUI

@main
struct AfterschoolApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(\.diContainer, DIContainer())
        }
    }
}
