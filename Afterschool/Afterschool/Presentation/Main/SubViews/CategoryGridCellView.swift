//
//  CategoryGridCellView.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/25/25.
//

import SwiftUI

struct CategoryGridCellView: View {
    let category: MealCategory
    let isSelected: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(isSelected ? Color.afGray50 : .clear)
                .frame(width: 74, height: 86)
            VStack(alignment: .center, spacing: 4) {
                category.image
                    .resizable()
                    .frame(width: 50, height: 50)
                Text(category.displayName)
                    .font(isSelected ? .afBold14 : .afRegular13)
                    .lineHeight(1.2, fontSize: 13)
                    .foregroundStyle(Color.afBlack)
            }
//            .frame(width: 74, height: 86)
        }
        .contentShape(RoundedRectangle(cornerRadius: 12))
    }
}
