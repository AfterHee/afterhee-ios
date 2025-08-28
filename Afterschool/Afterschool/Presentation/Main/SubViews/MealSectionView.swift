//
//  MealSectionView.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/24/25.
//

import SwiftUI

struct MealSectionView: View {
    @ObservedObject var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("식단표")
                        .font(.afBold20)
                        .lineHeight(1.2, fontSize: 20)
                        .foregroundStyle(Color.afGray900)
                    Text("학교 식단과 겹치지 않는 메뉴로 추천해줍니다.")
                        .font(.afMedium14)
                        .lineHeight(1.2, fontSize: 14)
                        .foregroundStyle(Color.afGray600)
                }
                Spacer()
            }
            MenuCarouselView(
                menus: viewModel.menus,
                selectedIndex: $viewModel.selectedMenuIndex
            )
            .ignoresSafeArea(.all, edges: .horizontal)
        }
    }
}
