//
//  MealCategory.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/25/25.
//

import SwiftUI

public enum MealCategory: String, CaseIterable, Identifiable, Hashable {
    case korean
    case chinese
    case japanese
    case western
    case asian
    case globalfood
    case steamed
    case soup
    case stirfry
    case rice
    case noodle
    case bread
    case seafood
    case meat
    case vegetable
    case fastmeal
    case dessert
    
    public var id: String { rawValue }
}
