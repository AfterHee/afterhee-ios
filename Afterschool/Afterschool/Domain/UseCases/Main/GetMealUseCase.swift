//
//  GetMealUseCase.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/28/25.
//

import Foundation

struct GetMealsUseCase {
    let serverRepository: MainServerRepositoryProtocol
    let getSelectedSchool: GetSelectedSchoolUseCase
    
    init(serverRepository: MainServerRepositoryProtocol,
         getSelectedSchool: GetSelectedSchoolUseCase) {
        self.serverRepository = serverRepository
        self.getSelectedSchool = getSelectedSchool
    }
    
    func execute(today: Date = Date()) async throws -> [MealDTO] {
        guard let selected = getSelectedSchool.execute() else {
            fatalError("Selected school must exist before calling GetMealsUseCase.")
        }
        
        let cal = Calendar.seoul
        let startOfToday = cal.startOfDay(for: today)
        let yesterday = cal.date(byAdding: .day, value: -1, to: startOfToday)!
        let tomorrow  = cal.date(byAdding: .day, value:  1, to: startOfToday)!
        
        let envelope = try await serverRepository.getMeals(
            eduOfficeCode: selected.eduOfficeCode,
            schoolCode: selected.adminCode,
            from: yesterday,
            to: tomorrow
        )
        let dtos = envelope.data
        
        let targets = Set([yesterday, startOfToday, tomorrow].map { cal.startOfDay(for: $0) })
        let lunchOnly = dtos.filter { dto in
            (dto.mmealScCode == "2" || dto.mmealScNm == "중식") &&
            (DateFormatter.yyyymmddKST.date(from: dto.mlsvYmd).map { targets.contains(cal.startOfDay(for: $0)) } ?? false)
        }
        
        return lunchOnly.sorted { $0.mlsvYmd < $1.mlsvYmd }
    }

    func execute(eduOfficeCode: String, schoolCode: String, today: Date = Date()) async throws -> [MealDTO] {
        let cal = Calendar.seoul
        let startOfToday = cal.startOfDay(for: today)
        let yesterday = cal.date(byAdding: .day, value: -1, to: startOfToday)!
        let tomorrow  = cal.date(byAdding: .day, value:  1, to: startOfToday)!
        
        let envelope = try await serverRepository.getMeals(
            eduOfficeCode: eduOfficeCode,
            schoolCode: schoolCode,
            from: yesterday,
            to: tomorrow
        )
        let dtos = envelope.data
        
        let formatter = DateFormatter.yyyymmddKST
        let targets = Set([yesterday, startOfToday, tomorrow].map { cal.startOfDay(for: $0) })
        
        let lunchOnly = dtos.filter { dto in
            (dto.mmealScCode == "2" || dto.mmealScNm == "중식") &&
            (formatter.date(from: dto.mlsvYmd).map { targets.contains(cal.startOfDay(for: $0)) } ?? false)
        }
        
        return lunchOnly.sorted { $0.mlsvYmd < $1.mlsvYmd }
    }
}
