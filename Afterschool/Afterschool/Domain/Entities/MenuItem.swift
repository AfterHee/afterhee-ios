//
//  MenuItem.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/25/25.
//

import Foundation

public struct MenuItem: Identifiable, Hashable, Sendable {
    public let id: String
    public let name: String

    public init(id: String = UUID().uuidString, name: String) {
        self.id = id
        self.name = name
    }
}
