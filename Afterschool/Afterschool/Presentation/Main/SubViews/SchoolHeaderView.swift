//
//  SchoolHeaderView.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/24/25.
//

import SwiftUI

struct SchoolHeaderView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        HStack(spacing: 6) {
            Text(viewModel.schoolName)
                .font(.afSemiBold18)
                .lineHeight(1.5, fontSize: 18)
                .foregroundStyle(Color.afGray900)
            Button {
                viewModel.schoolChangeButtonTapped()
            } label: {
                Image(systemName: "arrow.left.arrow.right")
                    .resizable()
                    .frame(width: 14, height: 15)
                    .foregroundStyle(Color.afGray600)
            }
            Spacer()
        }
    }
}
