//
//  MealCategory.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/25/25.
//

import SwiftUI

public enum MealCategory: String, CaseIterable, Identifiable, Hashable {
    case korean, chinese, japanese, western, asian, globalfood, steamed, soup, stirfry, rice, noodle, bread, seafood, meat, vegetable, fastmeal, dessert
    public var id: String { rawValue }
}
