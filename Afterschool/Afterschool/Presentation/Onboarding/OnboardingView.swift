//
//  OnboardingView.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/28/25.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var shouldShowOnboarding: Bool
    @ObservedObject var navigationRouter: NavigationRouter
    
    var onFinished: (() -> Void)? = nil
    
    var body: some View {
        VStack {
            Spacer()
            Image(.appTextLogo)
            Spacer()
            PrimaryButton(type: .findSchool, disabled: false) {
                onFinished?()
                print("학교 찾기 버튼이 눌렸습니다.")
                // TODO: 학교 찾기 완료 후 UserDefaults의 onboardingShown을 true로 변경해야 하지만 현재는 여기에서 변경하는 중
//                UserDefaults.standard.set(true, forKey: UserDefaultsKey.onboardingShown.rawValue)
//                shouldShowOnboarding = false
                navigationRouter.push(.schoolSetting(isOnboarding: true))
            }
            .primaryButtonDefaultFrame()
            .safeAreaPadding(.horizontal, 16)
        }
    }
}
