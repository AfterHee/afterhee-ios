//
//  LoadingAndResultViewModel.swift
//  Afterschool
//
//  Created by 임영택 on 8/26/25.
//

import Foundation

protocol LoadingAndResultViewModelProtocol {
    var recommendationMenuName: String? { get set }
    var isFloatingAnimationStopped: Bool { get }
    var retryCount: Int { get }
    var isLoading: Bool { get }
    var backgroundEffectOpacity: CGFloat { get }
    
    func loadingAnimationFinihed()
    func animateAfterLoadingAnimationFinihed()
    func retryButtonTapped()
    func viewAppeared()
}

@Observable
class LoadingAndResultViewModel: LoadingAndResultViewModelProtocol {
    var recommendationMenuName: String?
    private(set) var isFloatingAnimationStopped = false
    private(set) var retryCount = 0
    private(set) var isLoading = true
    private(set) var backgroundEffectOpacity: CGFloat = 0
    
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
            self?.recommendationMenuName = "뿌링클"
        }
    }
    
    /// 뷰 노출 핸들러
    func viewAppeared() {
        // TODO: 디버그 용 결과 표출 로직. 유즈케이스 구현 후 제거.
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.recommendationMenuName = "뿌링클"
        }
    }
}
