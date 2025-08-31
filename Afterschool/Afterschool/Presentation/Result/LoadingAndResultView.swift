//
//  LoadingAndResultView.swift
//  Afterschool
//
//  Created by 임영택 on 8/25/25.
//

import SwiftUI

struct LoadingAndResultView: View {
    // MARK: - Properties
    @StateObject private var viewModel: LoadingAndResultViewModel
    
    init(deps: LoadingAndResultDepsProviding, category: MealCategory, skipMenus: [String]) {
        self._viewModel = .init(
            wrappedValue: deps.getLoadingAndResultViewModel(category: category, skipMenus: skipMenus)
        )
    }
    
    // MARK: - Constraints
    private let backgroundColor = Color(hex: "#545454")
    private let animationDuration: Double = 0.7
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            LoadingAndResultViewNavigationBar()
            
            VStack(spacing: 0) {
                Spacer()
                
                VStack {
                    LoadingAndResultTitleLabel()
                    
                    ZStack {
                        Image(.backgroundEffect)
                            .opacity(viewModel.backgroundEffectOpacity)
                            .frame(width: UIScreen.main.bounds.width)
                        
                        LoadingCard(recommendation: $viewModel.recommendationMenuName) {
                            // 애니메이션 종료 후 수행할 일
                            viewModel.loadingAnimationFinihed()
                        }
                    }
                }
                
                Spacer()
            }
            .ignoresSafeArea(.all, edges: .top)
            
            VStack {
                Spacer()
                
                if viewModel.retryCount > 0 {
                    VStack(spacing: 16) {
                        if viewModel.retryButtonActivated {
                            RetryGuideLabel()
                        }
                        
                        PrimaryButton(viewModel.retryButtonLabel, disabled: !viewModel.retryButtonActivated) {
                            viewModel.retryButtonTapped()
                        }
                        .primaryButtonDefaultFrame()
                        .padding(.horizontal, 16)
                    }
                }
            }
        }
        .errorAlert(
            title: "추천 메뉴를 불러오지 못했어요.",
            buttonTitle: "다시 시도하기",
            isPresented: $viewModel.isError,
            action: {
                viewModel.retryButtonTapped()
            }
        )
        .onAppear {
            viewModel.viewAppeared()
        }
        .onChange(of: viewModel.isFloatingAnimationStopped) { oldValue, newValue in
            // 로딩 애니메이션 종료 후 애니메이션
            if newValue {
                withAnimation(.easeInOut(duration: animationDuration)) {
                    viewModel.animateAfterLoadingAnimationFinihed()
                }
            }
        }
        .toolbar(.hidden)
    }
}

#Preview {
    LoadingAndResultView(
        deps: LoadingAndResultDepsProvider(navigationRouter: NavigationRouter()),
        category: .asian,
        skipMenus: []
    )
}
