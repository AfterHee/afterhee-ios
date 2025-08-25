//
//  DailyMenu.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/25/25.
//

import Foundation

public struct DailyMenu: Identifiable, Hashable, Sendable {
    public let id: String
    public let date: Date
    public let items: [MenuItem]

    public init(id: String = UUID().uuidString, date: Date, items: [MenuItem]) {
        self.id = id
        self.date = date
        self.items = items
    }
}
