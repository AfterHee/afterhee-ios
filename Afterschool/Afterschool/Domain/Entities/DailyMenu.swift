//
//  DailyMenu.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/25/25.
//

import Foundation

struct DailyMenu: Identifiable, Hashable {
    let id = UUID()
    let date: Date
    let items: [MenuItem]
}

