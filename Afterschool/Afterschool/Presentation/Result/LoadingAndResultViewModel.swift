//
//  LoadingAndResultViewModel.swift
//  Afterschool
//
//  Created by 임영택 on 8/26/25.
//

import Foundation
import SwiftUI

class LoadingAndResultViewModel: ObservableObject {
    @Published var recommendationMenuName: String?
    @Published private(set) var isFloatingAnimationStopped = false
    @Published private(set) var retryCount = 0
    @Published private(set) var isLoading = true
    @Published private(set) var backgroundEffectOpacity: CGFloat = 0
    @Published private(set) var tryCount = 0
    
    var retryButtonLabel: LocalizedStringKey {
        retryCount >= 5
            ? "더 이상 다시 뽑을 수 없어요"
            : "다시 뽑기 (\(retryCount)/5)"
    }
    
    var retryButtonActivated: Bool {
        !isLoading && retryCount < 5
    }
    
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.tryCount += 1
            self?.recommendationMenuName = "뿌링클"
        }
    }
    
    /// 뷰 노출 핸들러
    func viewAppeared() {
        // TODO: 디버그 용 결과 표출 로직. 유즈케이스 구현 후 제거.
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.tryCount += 1
            self?.recommendationMenuName = "뿌링클"
        }
    }
}
