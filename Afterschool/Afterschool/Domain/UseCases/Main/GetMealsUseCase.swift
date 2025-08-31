//
//  GetMealsUseCase.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/29/25.
//

import Foundation

struct GetMealsUseCase {
    let serverRepository: MainServerRepositoryProtocol
    let userDefaultsRepository: UserDefaultsRepositoryProtocol
    
    init(serverRepository: MainServerRepositoryProtocol,
         userDefaultsRepository: UserDefaultsRepositoryProtocol) {
        self.serverRepository = serverRepository
        self.userDefaultsRepository = userDefaultsRepository
    }
    
    /// UserDefaults에 저장된 선택 학교 기준으로 어제/오늘/내일 '중식'만 반환
    func execute(today: Date = Date()) async throws -> [MealDTO] {
        guard let selected: School = userDefaultsRepository.load(School.self, forKey: .selectedSchool) else {
            throw GetMealsError.selectedSchoolNotFound
        }
        return try await execute(
            eduOfficeCode: selected.sidoCode,
            schoolCode: selected.adminCode,
            today: today
        )
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

enum GetMealsError: Error, LocalizedError {
    case selectedSchoolNotFound

    var errorDescription: String? {
        switch self {
        case .selectedSchoolNotFound:
            return "선택된 학교 정보를 찾을 수 없습니다."
        }
    }
}
