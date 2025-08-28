//
//  MainServerRepositoryProtocol.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/28/25.
//

import Foundation

protocol MainServerRepositoryProtocol {
    func getSchools(keyword: String) async throws -> BaseResponseDTO<[SchoolDTO]>
    func getMeals(eduOfficeCode: String, schoolCode: String, from: Date, to: Date) async throws -> BaseResponseDTO<[MealDTO]>
    func getSuggest(category: String, skipMenus: [String]) async throws -> BaseResponseDTO<SuggestDTO>
}
