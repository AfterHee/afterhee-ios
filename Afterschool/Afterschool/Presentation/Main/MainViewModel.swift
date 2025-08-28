//
//  MainViewModel.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/24/25.
//

import Foundation

final class MainViewModel: ObservableObject {
    private var navigationRouter: NavigationRouter
    private let getOnboarindgShownUseCase: GetOnboardingShownUseCase
    
    @Published var schoolName: String = "애플고등학교"
    @Published var selectedCategory: MealCategory? = nil
    @Published var shouldShowOnboarding: Bool = false
        
    // TODO: 연결 필요
    @Published var menus: [DailyMenu] = {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        return [
            DailyMenu(
                date: cal.date(byAdding: .day, value: -1, to: today)!,
                items: [
                    .init(name: "쌀밥"), .init(name: "된장찌개"), .init(name: "제육볶음")
                ]
            ),
            DailyMenu(
                date: today,
                items: [
                    .init(name: "흑미밥"),
                    .init(name: "육개장"),
                    .init(name: "김치전"),
                    .init(name: "요구르트")
                ]
            ),
            DailyMenu(
                date: cal.date(byAdding: .day, value: 1, to: today)!,
                items: [] // 급식 정보 없음 케이스
            )
        ]
    }()
    
    @Published var selectedMenuIndex: Int = 1
    
    let categories: [MealCategory] = MealCategory.allCases
    
    init(
        navigationRouter: NavigationRouter,
        getOnboarindgShownUseCase: GetOnboardingShownUseCase
    ) {
        self.navigationRouter = navigationRouter
        self.getOnboarindgShownUseCase = getOnboarindgShownUseCase
    }
    
    func selectCategory(_ category: MealCategory) {
        selectedCategory = (selectedCategory == category) ? nil : category // 선택한 카테고리 한 번 더 선택시 미선택(nil)으로 변경
    }
    
    func schoolChangeButtonTapped() {
        print("학교 변경 버튼이 눌렸습니다.")
        navigationRouter.push(.schoolSetting(isOnboarding: true))
    }
    
    func getRecommendationButtonTapped() {
        print("추천 받기 버튼이 눌렸습니다.")
    }
    
    func mainViewAppeared() {
        shouldShowOnboarding = !getOnboarindgShownUseCase.execute()
    }
}
