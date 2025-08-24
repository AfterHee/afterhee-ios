//
//  CategorySelectSectionView.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/24/25.
//

import SwiftUI

struct CategorySelectSectionView: View {
    @ObservedObject var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 5)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 8){
                Text("메뉴 고르기")
                    .font(.afBold20)
                    .lineHeight(1.2, fontSize: 20)
                    .foregroundStyle(Color.afGray900)
                Text("지금 먹고 싶은 음식의 카테고리를 선택해주세요.")
                    .font(.afMedium14)
                    .lineHeight(1.2, fontSize: 14)
                    .foregroundStyle(Color.afGray600)
            }
            LazyVGrid(columns: columns, alignment: .center, spacing: 16) {
                ForEach(viewModel.categories) { category in
                    Button{
                        viewModel.selectCategory(category)
                    } label: {
                        CategoryGridCellView(category: category, isSelected: viewModel.selectedCategory == category)
                    }
                }
            }
        }
        .padding(.horizontal, 7) // 23 - 16 = 7
    }
}
