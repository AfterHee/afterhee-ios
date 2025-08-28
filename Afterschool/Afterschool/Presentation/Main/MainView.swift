//
//  MainView.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/24/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel: MainViewModel
    
    init(deps: MainDepsProviding) {
        self._viewModel = StateObject(wrappedValue: deps.getMainViewModel())
    }
    
    var body: some View {
        Group {
            if viewModel.shouldShowOnboarding {
                OnboardingView(shouldShowOnboarding: $viewModel.shouldShowOnboarding)
            } else {
                ZStack {
                    ScrollView {
                        VStack(spacing: 56) {
                            VStack(alignment: .leading, spacing: 16) { 
                                SchoolHeaderView(viewModel: viewModel)
                                MealSectionView(viewModel: viewModel)
                            }
                            CategorySelectSectionView(viewModel: viewModel)
                            
                        }
                        .safeAreaPadding(.horizontal, 16)
                        Spacer().frame(height: 120)
                    }
                    VStack {
                        Spacer()
                        
                        PrimaryButton(type: .getSuggestion, disabled: viewModel.selectedCategory == nil) {
                            viewModel.getRecommendationButtonTapped()
                        }
                        .primaryButtonDefaultFrame()
                        .safeAreaPadding(.horizontal, 16)
                    }
                }
            }
        }
        .onAppear {
            viewModel.mainViewAppeared()
        }
    }
}

#Preview {
    struct MainViewWrapper: View {
        @Environment(\.diContainer) var diContainer
        
        var body: some View {
            MainView(deps: diContainer.mainDepsProvider)
        }
    }
    
    return MainViewWrapper()
        .environment(\.diContainer, DIContainer())
}
