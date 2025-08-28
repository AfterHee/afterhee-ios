//
//  MainViewModel.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/24/25.
//

import Foundation

final class MainViewModel: ObservableObject {
    private let getOnboarindgShownUseCase: GetOnboardingShownUseCase
    private let getMealUseCase: GetMealsUseCase
    private let getSelectedSchool: GetSelectedSchoolUseCase
    
    @Published var schoolName: String = "학교를 선택해 주세요"
    @Published var selectedCategory: MealCategory? = nil
    @Published var shouldShowOnboarding: Bool = false
    @Published var isLoadingMenu: Bool = false
    @Published var loadErrorMessage: String? = nil
    @Published var menus: [DailyMenu] = []
    @Published var selectedMenuIndex: Int = 1
    
    let categories: [MealCategory] = MealCategory.allCases
    
    init(
        getOnboarindgShownUseCase: GetOnboardingShownUseCase,
        getMealUseCase: GetMealsUseCase,
        getSelectedSchool: GetSelectedSchoolUseCase,
    ) {
        self.getOnboarindgShownUseCase = getOnboarindgShownUseCase
        self.getMealUseCase = getMealUseCase
        self.getSelectedSchool = getSelectedSchool
        
        guard let selectedSchool = getSelectedSchool.execute() else {
            fatalError("Selected school must exist before MainViewModel initialization.")
        }
        self.schoolName = selectedSchool.name
    }
    
    func selectCategory(_ category: MealCategory) {
        selectedCategory = (selectedCategory == category) ? nil : category // 선택한 카테고리 한 번 더 선택시 미선택(nil)으로 변경
    }
    
    func schoolChangeButtonTapped() {
        print("학교 변경 버튼이 눌렸습니다.")
    }
    
    func getRecommendationButtonTapped() {
        print("추천 받기 버튼이 눌렸습니다.")
    }
    
    func mainViewAppeared() {
        shouldShowOnboarding = !getOnboarindgShownUseCase.execute()
        Task { await refreshMenus() }
    }
    
    func refreshMenus(today: Date = Date()) async {
        isLoadingMenu = true; loadErrorMessage = nil
        defer { isLoadingMenu = false }
        
        do {
            let lunchDTOs = try await getMealUseCase.execute(today: today)
            let mapped = DailyMenuMapper.map(lunchDTOs)
            menus = mapped.ensuringPlaceholders(for: today, calendar: .seoul)
            if let idx = mapped.firstIndex(where: { Calendar.seoul.isDateInToday($0.date) }) {
                selectedMenuIndex = idx
            } else {
                selectedMenuIndex = min(1, max(0, mapped.count - 1))
            }
        } catch {
            loadErrorMessage = (error as NSError).localizedDescription
            menus = []
        }
    }
}
