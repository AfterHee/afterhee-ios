//
//  GetRecommendationUseCase.swift
//  Afterschool
//
//  Created by 임영택 on 8/29/25.
//

import Foundation

struct GetRecommendationUseCase {
    let repository: MainServerRepository
    
    init(repository: MainServerRepository) {
        self.repository = repository
    }
    
    func execute(category: MealCategory, skipMenus: [String]) async throws -> String {
        let result = try await repository.getSuggest(category: category.requestValue, skipMenus: skipMenus)
        return result.data.recommendation
    }
}
