//
//  MainView.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/24/25.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var navigationRouter: NavigationRouter
    @StateObject private var viewModel: MainViewModel
    
    init(deps: MainDepsProviding) {
        self._navigationRouter = ObservedObject(wrappedValue: deps.navigationRouter)
        self._viewModel = StateObject(wrappedValue: deps.getMainViewModel())
    }
    
    var body: some View {
        Group {
            if viewModel.shouldShowOnboarding {
                OnboardingView(shouldShowOnboarding: $viewModel.shouldShowOnboarding, navigationRouter: navigationRouter, onFinished: {
                    Task { await viewModel.onboardingFinished() }
                })
            } else {
                if viewModel.isSplashFinished {
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
                        .scrollIndicators(.hidden)
                        VStack {
                            Spacer()
                            PrimaryButton(type: .getSuggestion, disabled: viewModel.selectedCategory == nil) {
                                viewModel.getRecommendationButtonTapped()
                            }
                            .primaryButtonDefaultFrame()
                            .safeAreaPadding(.horizontal, 16)
                        }
                    }
                } else {
                    SplashView()
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .task {
                            try? await Task.sleep(nanoseconds: 1_250_000_000)
                            viewModel.isSplashFinished = true
                        }
                }
            }
        }
        .task(id: viewModel.refreshTaskId) {
            await viewModel.refresh()
        }
        .onAppear {
            viewModel.mainViewAppeared()
        }
        .onChange(of: viewModel.shouldShowOnboarding) { _, shown in
            if !shown {
                viewModel.onboardingDismissed()
            }
        }
        .onChange(of: viewModel.navigationPath) { oldValue, newValue in
            viewModel.navigationPathChanged()
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
