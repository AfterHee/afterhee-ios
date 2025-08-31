//
//  MenuCarouselView.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/25/25.
//

import SwiftUI

struct MenuCarouselView: View {
    let menus: [DailyMenu]                   // [어제, 오늘, 내일] (최대 3개 가정)
    @Binding var selectedIndex: Int          // 0: 어제, 1: 오늘, 2: 내일
    
    private let minRows: Int = 3
    private let contentVPadding: CGFloat = 16
    private let outerPadding: CGFloat = 12
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedIndex) {
                ForEach(Array(menus.enumerated()), id: \.offset) { index, menu in
                    MenuCarouselCardView(
                        menu: menu,
                        relativeLabel: relativeDayLabel(for: index),
                        infoHeight: uniformHeight,
                        minRows: minRows
                    )
                    .frame(width: cardWidth, height: uniformHeight + 66)
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: uniformHeight + 70)
            
            HStack(spacing: 16) {
                if selectedIndex > 0 {
                    Button {
                        selectedIndex -= 1
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 18, height: 29)
                            .foregroundStyle(Color.afGray400)
                    }
                    .transition(.opacity)
                } else {
                    Spacer().frame(width: 18)
                }
                
                Spacer()
                
                if selectedIndex < max(0, menus.count - 1) {
                    Button {
                        selectedIndex += 1
                    } label: {
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 18, height: 29)
                            .foregroundStyle(Color.afGray400)
                    }
                    .transition(.opacity)
                } else {
                    Spacer().frame(width: 18)
                }
            }
            .safeAreaPadding(.horizontal, 16)
        }
    }
    
    private var cardWidth: CGFloat {
        UIScreen.main.bounds.width - 100
    }
    
    private var uniformHeight: CGFloat {
        let heights = menus.map { cardHeight(for: $0.items.count) }
        return heights.max() ?? cardHeight(for: minRows)
    }

    private func cardHeight(for count: Int) -> CGFloat {
        let rows = max(count, minRows)
        let listHeight = CGFloat(rows) * 25
        return listHeight
    }
    
    private func relativeDayLabel(for index: Int) -> String {
        switch index {
        case 0: "어제"
        case 1: "오늘"
        case 2: "내일"
        default: ""
        }
    }
}
