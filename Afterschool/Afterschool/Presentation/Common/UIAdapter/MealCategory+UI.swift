//
//  MealCategory+UI.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/25/25.
//

import SwiftUI

extension MealCategory {
    var displayName: String {
        switch self {
        case .korean:     return "한식"
        case .chinese:    return "중식"
        case .japanese:   return "일식"
        case .western:    return "양식"
        case .asian:      return "아시안"
        case .globalfood: return "세계음식"
        case .steamed:    return "찜"
        case .soup:       return "국물"
        case .stirfry:    return "볶음"
        case .rice:       return "밥"
        case .noodle:     return "면"
        case .bread:      return "빵"
        case .seafood:    return "해산물"
        case .meat:       return "고기"
        case .vegetable:  return "야채"
        case .fastmeal:   return "빠른 식사"
        case .dessert:    return "디저트"
        }
    }
    
    var image: Image {
        Image(self.rawValue)
    }
}

