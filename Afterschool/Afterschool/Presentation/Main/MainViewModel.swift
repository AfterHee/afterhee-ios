//
//  MainViewModel.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/24/25.
//

import Foundation
import os.log

final class MainViewModel: ObservableObject {
    private var navigationRouter: NavigationRouter
    private let setOnboarindgShownUseCase: SetOnboardingShownUseCase
    private let getOnboarindgShownUseCase: GetOnboardingShownUseCase
    private let getMealUseCase: GetMealsUseCase
    private let getSelectedSchool: GetSelectedSchoolUseCase
    private let logger = Logger.makeOf("MainViewModel")
    
    @Published var schoolName: String = "학교를 선택해 주세요"
    @Published var selectedCategory: MealCategory? = nil
    @Published var shouldShowOnboarding: Bool = false
    @Published var isLoadingMenu: Bool = false
    @Published var loadErrorMessage: String? = nil
    @Published var menus: [DailyMenu] = []
    @Published var selectedMenuIndex: Int = 1
    
    let categories: [MealCategory] = MealCategory.allCases
    
    init(
        setOnboarindgShownUseCase: SetOnboardingShownUseCase,
        getOnboarindgShownUseCase: GetOnboardingShownUseCase,
        getMealUseCase: GetMealsUseCase,
        getSelectedSchool: GetSelectedSchoolUseCase,

        navigationRouter: NavigationRouter,
    ) {
        self.navigationRouter = navigationRouter
        self.setOnboarindgShownUseCase = setOnboarindgShownUseCase
        self.getOnboarindgShownUseCase = getOnboarindgShownUseCase
        self.getMealUseCase = getMealUseCase
        self.getSelectedSchool = getSelectedSchool
        
        if let selectedSchool = getSelectedSchool.execute() {
            self.schoolName = selectedSchool.name
        } else {
            do {
                try setOnboarindgShownUseCase.execute(value: false)
            } catch {
                logger.error("❌ setOnboarindgShownUseCase failed: \(error)")
            }
        }
    }
    
    var uniqueMenuItemNames: [String] {
        Array(Set(menus.flatMap { $0.items.map(\.name) }))
    }
    
    func selectCategory(_ category: MealCategory) {
        selectedCategory = (selectedCategory == category) ? nil : category // 선택한 카테고리 한 번 더 선택시 미선택(nil)으로 변경
    }
    
    func schoolChangeButtonTapped() {
        print("학교 변경 버튼이 눌렸습니다.")
        navigationRouter.push(.schoolSetting(isOnboarding: true))
    }
    
    func getRecommendationButtonTapped() {
        if let category = selectedCategory {
            navigationRouter.push(.result(category: category, skipMenus: uniqueMenuItemNames))
        }
    }
    
    func mainViewAppeared() {
        shouldShowOnboarding = !getOnboarindgShownUseCase.execute()
        Task { @MainActor in
            await refreshMenus()
        }
    }
    
    func refreshMenus(today: Date = Date()) async {
        await MainActor.run {
            isLoadingMenu = true
            loadErrorMessage = nil
        }
        do {
            let lunchDTOs = try await getMealUseCase.execute(today: today)
            let mapped = DailyMenuMapper.map(lunchDTOs)
            let filled = mapped.ensuringPlaceholders(for: today, calendar: .seoul)
            
            await MainActor.run {
                menus = filled
                if let idx = filled.firstIndex(where: { Calendar.seoul.isDateInToday($0.date) }) {
                    selectedMenuIndex = idx
                } else {
                    selectedMenuIndex = min(1, max(0, filled.count - 1))
                }
                isLoadingMenu = false
            }
        } catch {
            await MainActor.run {
                loadErrorMessage = (error as NSError).localizedDescription
                menus = []
                isLoadingMenu = false
            }
        }
    }
    
    @MainActor
    func onboardingFinished() async {
        do {
            try setOnboarindgShownUseCase.execute(value: true)
        } catch {
            logger.error("❌ setOnboarindgShownUseCase failed: \(error)")
        }
        shouldShowOnboarding = !getOnboarindgShownUseCase.execute()
        if !shouldShowOnboarding {
            await refreshMenus()
            if let selectedSchool = getSelectedSchool.execute() {
                self.schoolName = selectedSchool.name
            }
        }
    }
    
    @MainActor
    func onboardingDismissed() async {
        shouldShowOnboarding = !getOnboarindgShownUseCase.execute()
        if !shouldShowOnboarding {
            await refreshMenus()
            if let selectedSchool = getSelectedSchool.execute() {
                self.schoolName = selectedSchool.name
            }
        }
    }
}
