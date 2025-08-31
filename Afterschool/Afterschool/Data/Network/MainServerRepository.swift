//
//  MainServerRepository.swift
//  Afterschool
//
//  Created by 임영택 on 8/24/25.
//  Edited by BoMin Lee on 8/28/25.
//

import Foundation

class MainServerRepository: MainServerRepositoryProtocol {
    let network: Network
    
    init(network: Network = Network()) {
        self.network = network
    }
    
    func getSchools(keyword: String) async throws -> BaseResponseDTO<[SchoolDTO]?> {
        do {
            let target: MainServerTarget = .getSchool(keyword: keyword)
            let value: BaseResponseDTO<[SchoolDTO]?> = try await network.task(target)
            return value
        } catch {
            throw error
        }
    }
    
    func getMeals(eduOfficeCode: String, schoolCode: String, from: Date, to: Date) async throws -> BaseResponseDTO<[MealDTO]> {
        do {
            let target: MainServerTarget = .getMeal(
                eduOfficeCode: eduOfficeCode,
                schoolCode: schoolCode,
                from: from.dateString,
                to: to.dateString
            )
            let value: BaseResponseDTO<[MealDTO]> = try await network.task(target)
            return value
        } catch {
            throw error
        }
    }
    
    func getSuggest(category: String, skipMenus: [String]) async throws -> BaseResponseDTO<SuggestDTO> {
        do {
            let target: MainServerTarget = .suggest(category: category, skipMenus: skipMenus)
            let value: BaseResponseDTO<SuggestDTO> = try await network.task(target)
            return value
        } catch {
            throw error
        }
    }
}
