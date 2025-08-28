//
//  Environment+.swift
//  Afterschool
//
//  Created by 임영택 on 8/28/25.
//

import Foundation
import SwiftUI

private struct DIConatinerKey: EnvironmentKey {
    static let defaultValue: DIContainer = DIContainer()
}

extension EnvironmentValues {
    var diContainer: DIContainer {
        get { self[DIConatinerKey.self] }
        set { self[DIConatinerKey.self] = newValue }
    }
}
