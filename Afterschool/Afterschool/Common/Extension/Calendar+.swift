//
//  Calendar+.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/28/25.
//

import Foundation

extension Calendar {
    static let seoul: Calendar = {
        var c = Calendar(identifier: .gregorian)
        c.timeZone = TimeZone(identifier: "Asia/Seoul") ?? .current
        return c
    }()
}
