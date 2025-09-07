//
//  MenuCarouselCardView.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/25/25.
//

import SwiftUI

struct MenuCarouselCardView: View {
    let menu: DailyMenu
    let relativeLabel: String
    let infoHeight: CGFloat
    let minRows: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.afGray50)
            VStack(spacing: 16) {
                if menu.items.isEmpty {
                    ZStack {
                        VStack {
                            HStack(spacing: 6) {
                                Text(menu.dateFormatted)
                                    .font(.afMedium14)
                                    .lineHeight(1.2, fontSize: 14)
                                    .foregroundStyle(Color.afGray900)
                                Text(relativeLabel)
                                    .font(.afBold14)
                                    .lineHeight(1.2, fontSize: 14)
                                    .foregroundStyle(relativeLabel=="오늘" ? Color.afPrimary : Color.afGray600)
                            }
                            Spacer()
                        }
                        VStack {
                            Spacer()
                            Text("급식 정보가 없어요")
                                .font(.afMedium14)
                                .lineHeight(1.2, fontSize: 14)
                                .foregroundStyle(Color.afGray200)
                                .frame(maxWidth: .infinity)
                                .frame(height: infoHeight)
                            Spacer()
                        }
                    }
                } else {
                    HStack(spacing: 6) {
                        Text(menu.dateFormatted)
                            .font(.afMedium14)
                            .lineHeight(1.2, fontSize: 14)
                            .foregroundStyle(Color.afGray900)
                        Text(relativeLabel)
                            .font(.afBold14)
                            .lineHeight(1.2, fontSize: 14)
                            .foregroundStyle(relativeLabel=="오늘" ? Color.afPrimary : Color.afGray600)
                    }
                    VStack(alignment: .center, spacing: 6) {
                        ForEach(menu.items) { item in
                            Text(item.name)
                                .lineLimit(1)
                                .font(.afRegular14)
                                .lineHeight(1.2, fontSize: 14)
                                .foregroundStyle(Color.afGray900)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: infoHeight)
                }
            }
            .padding(.vertical, 16)
        }
        .contentShape(RoundedRectangle(cornerRadius: 12))
    }
}
