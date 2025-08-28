//
//  LoadingCardLabels.swift
//  Afterschool
//
//  Created by 임영택 on 8/26/25.
//


import SwiftUI

struct LoadingAndResultTitleLabel: View {
    var body: some View {
        Text("오늘 뭐 먹을까?")
            .foregroundStyle(Color.afWhite)
            .font(.afBold20)
            .lineHeight(24 / 20, fontSize: 20)
    }
}

struct RetryGuideLabel: View {
    var body: some View {
        Text("최대 5번까지 또 다른 메뉴를 다시 뽑을 수 있어요")
            .foregroundStyle(Color.afPrimary)
            .font(.afMedium14)
            .lineHeight(17 / 14, fontSize: 14)
    }
}
