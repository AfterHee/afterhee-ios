//
//  Logger+Helper.swift
//  Afterschool
//
//  Created by 임영택 on 8/28/25.
//

import Foundation
import os.log

extension Logger {
    private static let bundleIdentifier: String = Bundle.main.bundleIdentifier ?? "com.afterhee.Afterschool"
    
    static func makeOf(_ category: String) -> Logger {
        .init(subsystem: bundleIdentifier, category: category)
    }
}
