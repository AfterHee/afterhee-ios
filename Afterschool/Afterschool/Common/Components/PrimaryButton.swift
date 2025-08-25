//
//  PrimaryButton.swift
//  Afterschool
//
//  Created by 임영택 on 8/25/25.
//

import SwiftUI

/// 공통 컴포넌트 버튼. 크기를 커스텀하고 싶다면, width와 height를 생성자에 지정한다.
struct PrimaryButton: View {
    // MARK: - Properties
    private let label: String
    private let disabled: Bool
    private let didButtonTapped: () -> Void
    
    // MARK: - Constraints
    private static let defaultWidth: CGFloat = 393
    private static let defaultHeight: CGFloat = 64
    private let width: CGFloat
    private let height: CGFloat
    
    init(
        label: String,
        disabled: Bool = false,
        didButtonTapped: @escaping () -> Void,
        width: CGFloat = defaultWidth,
        height: CGFloat = defaultHeight
    ) {
        self.label = label
        self.disabled = disabled
        self.didButtonTapped = didButtonTapped
        self.width = width
        self.height = height
    }
    
    var body: some View {
        Button(action: didButtonTapped) {
            Text(label)
                .font(.afSemiBold18)
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .disabled(disabled)
        .buttonStyle(PrimaryButtonStyle())
        .frame(width: width, height: height)
    }
}

/// 공통 컴포넌트 버튼의 스타일. 눌렸을 때 버튼 상태를 정의한다.
fileprivate struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        let baseColor: Color = isEnabled ? .afPrimary : .afGray100
        let pressedColor: Color = isEnabled ? .afPrimaryDarken : .afGray100
        let fill = configuration.isPressed ? pressedColor : baseColor

        return configuration.label
            .background(
                RoundedRectangle(cornerRadius: 12, style: .circular)
                    .fill(fill)
            )
    }
}

#Preview {
    VStack {
        PrimaryButton(label: "테스트") {
            print("버튼이 눌렸습니다.")
        }
        
        PrimaryButton(label: "테스트", disabled: true) {
            print("버튼이 눌렸습니다.")
        }
    }
}
