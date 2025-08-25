//
//  MainViewModel.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/24/25.
//

import Foundation

final class MainViewModel: ObservableObject {
    @Published var schoolName: String = "애플고등학교"
    @Published var selectedCategory: MealCategory? = nil
    
    @Published var schoolChangeButtonTapped = false
    
    let categories: [MealCategory] = MealCategory.allCases
    
    func selectCategory(_ category: MealCategory) {
        selectedCategory = (selectedCategory == category) ? nil : category // 선택한 카테고리 한 번 더 선택시 미선택(nil)으로 변경
    }
}


