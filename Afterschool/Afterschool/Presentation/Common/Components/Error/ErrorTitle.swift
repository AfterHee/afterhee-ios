//
//  ErrorTitle.swift
//  Afterschool
//
//  Created by 임영택 on 8/28/25.
//

import SwiftUI

struct ErrorTitle: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.afSemiBold18)
            .lineHeight(27 / 18, fontSize: 18)
    }
}

#Preview {
    ErrorTitle(title: "추천 메뉴를 불러오지 못했어요.")
}
