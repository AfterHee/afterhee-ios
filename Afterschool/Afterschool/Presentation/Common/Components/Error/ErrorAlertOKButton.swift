//
//  ErrorAlertOKButton.swift
//  Afterschool
//
//  Created by 임영택 on 8/28/25.
//

import SwiftUI

struct ErrorAlertOKButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.afMedium16)
                .lineHeight(24 / 16, fontSize: 16)
                .foregroundStyle(Color.afGray600)
                .frame(maxWidth: .infinity, maxHeight: 64)
                .background(
                    Rectangle()
                        .foregroundStyle(Color.afWhite)
                        .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                )
        }
    }
}

#Preview {
    ErrorAlertOKButton(title: "확인") {
        //
    }
    .padding(.horizontal, 16)
}
