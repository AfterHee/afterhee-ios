//
//  MainView.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/24/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
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

#Preview {
    MainView()
}
