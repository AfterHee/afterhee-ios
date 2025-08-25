//
//  MenuCarouselCardView.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/25/25.
//

import SwiftUI

struct MenuCarouselCardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.afGray50)
            VStack(spacing: 16) {
                HStack {
                    Text("8월 18일 (월)") // TODO: 실제 데이터로 대체, DateFormatter 필요
                        .font(.afMedium14)
                        .lineHeight(1.2, fontSize: 14)
                        .foregroundStyle(Color.afGray900)
                    Text("오늘") // TODO: 실제 데이터로 대체 - 어제, 오늘, 내일 판별 필요
                }
                Spacer()
            }
            .padding(.vertical, 16)
            Text("급식 정보가 없어요")
                .font(.afMedium14)
                .lineHeight(1.2, fontSize: 14)
                .foregroundStyle(Color.afGray200)
        }
    }
}

#Preview {
    MenuCarouselCardView()
}
