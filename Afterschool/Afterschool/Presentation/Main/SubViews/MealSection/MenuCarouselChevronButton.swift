//
//  MenuCarouselChevronButton.swift
//  Afterschool
//
//  Created by 임영택 on 9/7/25.
//

import SwiftUI

struct MenuCarouselChevronButton: View {
    // MARK: Type Alias
    typealias ButtonType = MenuCarouselChevronButtonType
    
    // MARK: Properties
    let type: ButtonType
    let isShowing: Bool
    let action: () -> Void
    private var buttonImageName: String {
        type.imageName
    }
    
    // MARK: Constants
    private let areaHeight: CGFloat = 29
    private let areaWidth: CGFloat = 50
    private let innerPadding: CGFloat = 4
    
    var body: some View {
        if isShowing {
            Button (action: action) {
                Image(systemName: buttonImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(innerPadding)
                    .frame(width: areaWidth, height: areaHeight)
                    .foregroundStyle(Color.afGray400)
            }
        } else {
            Spacer()
                .frame(width: areaWidth, height: areaHeight)
        }
    }
}

enum MenuCarouselChevronButtonType {
    case previous
    case next
    
    var imageName: String {
        switch self {
        case .previous:
            return "chevron.left"
        case .next:
            return "chevron.right"
        }
    }
}

#Preview {
    struct PreviewContainer: View {
        @State private var showButton: Bool = true
        
        var body: some View {
            VStack {
                Button("Toggle") {
                    showButton.toggle()
                }
                
                HStack {
                    MenuCarouselChevronButton(type: .previous, isShowing: showButton) {
                        print("Previous Button Tapped")
                    }
                    
                    MenuCarouselChevronButton(type: .next, isShowing: showButton) {
                        print("Next Button Tapped")
                    }
                }
            }
        }
    }
    
    return PreviewContainer()
}
