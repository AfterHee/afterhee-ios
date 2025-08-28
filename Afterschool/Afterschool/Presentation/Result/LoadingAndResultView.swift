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
    
    init(viewModel: LoadingAndResultViewModel = LoadingAndResultViewModel()) {
        self._viewModel = .init(wrappedValue: viewModel)
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
    }
}

#Preview {
    LoadingAndResultView()
}
