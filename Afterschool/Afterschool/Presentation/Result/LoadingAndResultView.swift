//
//  LoadingAndResultView.swift
//  Afterschool
//
//  Created by 임영택 on 8/25/25.
//

import SwiftUI

struct LoadingAndResultView: View {
    // MARK: - Properties
    @State private var viewModel: LoadingAndResultViewModel
    
    init(viewModel: LoadingAndResultViewModel = LoadingAndResultViewModel()) {
        self.viewModel = viewModel
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
                            viewModel.isLoading = false
                            viewModel.isFloatingAnimationStopped = true
                            viewModel.retryCount += 1
                        }
                    }
                }
                
                Spacer()
            }
            .ignoresSafeArea(.all, edges: .top)
            
            VStack {
                Spacer()
                
                if viewModel.retryCount > 0 {
                    PrimaryButton(type: .retry, disabled: viewModel.isLoading) {
                        viewModel.retryTapped()
                    }
                    .primaryButtonDefaultFrame()
                    .padding(.horizontal, 16)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                viewModel.recommendationMenuName = "뿌링클"
            }
        }
        .onChange(of: viewModel.isFloatingAnimationStopped) { oldValue, newValue in
            if newValue {
                withAnimation(.easeInOut(duration: animationDuration)) {
                    viewModel.backgroundEffectOpacity = 1.0
                }
            }
        }
    }
}



#Preview {
    LoadingAndResultView()
}
