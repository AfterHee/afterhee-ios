//
//  LoadingAndResultViewModel.swift
//  Afterschool
//
//  Created by 임영택 on 8/26/25.
//

import Foundation
import SwiftUI
import os.log

final class LoadingAndResultViewModel: ObservableObject {
    let category: MealCategory
    var skipMenus: [String]
    let getRecommendationUseCase: GetRecommendationUseCase
    private let logger = Logger.makeOf("LoadingAndResultViewModel")
    
    init(
        category: MealCategory,
        skipMenus: [String],
        getRecommendationUseCase: GetRecommendationUseCase
    ) {
        self.category = category
        self.skipMenus = skipMenus
        self.getRecommendationUseCase = getRecommendationUseCase
    }
    
    @Published var recommendationMenuName: String?
    @Published private(set) var isFloatingAnimationStopped = false
    @Published private(set) var retryCount = 0
    @Published private(set) var isLoading = true
    @Published private(set) var backgroundEffectOpacity: CGFloat = 0
    @Published private(set) var tryCount = 0
    @Published var isError = false
    
    var retryButtonLabel: LocalizedStringKey {
        retryCount >= 5
            ? "더 이상 다시 뽑을 수 없어요"
            : "다시 뽑기 (\(retryCount)/5)"
    }
    
    var retryButtonActivated: Bool {
        !isLoading && retryCount < 5
    }
}

/// User Intents, View Life Cycle
extension LoadingAndResultViewModel {
    /// 로딩 애니메이션이 끝난 뒤 상태 변경
    func loadingAnimationFinihed() {
        isLoading = false
        isFloatingAnimationStopped = true
        retryCount += 1
    }
    
    /// 로딩 애니메이션이 끝난 뒤 뷰에서 withAnimation으로 래핑하여 실행할 작업들
    func animateAfterLoadingAnimationFinihed() {
        backgroundEffectOpacity = 1.0
    }
    
    /// 다시 추천 버튼 탭
    func retryButtonTapped() {
        recommendationMenuName = nil
        isFloatingAnimationStopped = false
        isLoading = true
        backgroundEffectOpacity = 0
        
        requestRecommendationMenu()
    }
    
    /// 뷰 노출 핸들러
    func viewAppeared() {
        requestRecommendationMenu()
    }
}

extension LoadingAndResultViewModel {
    func requestRecommendationMenu() {
        isError = false
        
        Task.detached { [weak self] in
            guard let self else { return }
            
            do {
                let recommendation = try await getRecommendationUseCase.execute(category: category, skipMenus: skipMenus)
                
                skipMenus.append(recommendation)
                
                await MainActor.run {
                    self.recommendationMenuName = recommendation
                }
            } catch {
                logger.error("❌ failed to get recommendation menu: \(error)")
                isError = true
            }
        }
    }
}
