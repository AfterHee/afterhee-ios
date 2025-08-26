//
//  LoadingAndResultViewModel.swift
//  Afterschool
//
//  Created by 임영택 on 8/26/25.
//

import Foundation

@Observable
class LoadingAndResultViewModel {
    var recommendationMenuName: String?
    var isFloatingAnimationStopped = false
    var retryCount = 0
    var isLoading = true
    var backgroundEffectOpacity: Double = 0
    
    func retryTapped() {
        recommendationMenuName = nil
        isFloatingAnimationStopped = false
        isLoading = true
        backgroundEffectOpacity = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.recommendationMenuName = "뿌링클"
        }
    }
}
