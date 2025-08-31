//
//  PrimaryButton.swift
//  Afterschool
//
//  Created by 임영택 on 8/25/25.
//

import SwiftUI

/// 공통 컴포넌트 버튼
struct PrimaryButton: View {
    // MARK: - Properties
    private let stringKey: LocalizedStringKey
    private let disabled: Bool
    private let didButtonTapped: () -> Void
    
    init(
        _ stringKey: LocalizedStringKey,
        disabled: Bool = false,
        didButtonTapped: @escaping () -> Void
    ) {
        self.stringKey = stringKey
        self.disabled = disabled
        self.didButtonTapped = didButtonTapped
    }
    
    init(
        type: DefaultPrimaryButtonType,
        disabled: Bool = false,
        didButtonTapped: @escaping () -> Void
    ) {
        self.stringKey = type.label
        self.disabled = disabled
        self.didButtonTapped = didButtonTapped
    }
    
    var body: some View {
        Button(action: didButtonTapped) {
            Text(stringKey)
                .font(.afSemiBold18)
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .disabled(disabled)
        .buttonStyle(PrimaryButtonStyle())
    }
}

// MARK: - Button Type
enum DefaultPrimaryButtonType {
    case findSchool // 우리학교 등록하기
    case getSuggestion // 추천받기
    case retry // 다시뽑기
    
    var label: LocalizedStringKey {
        switch self {
        case .findSchool:
            return "우리학교 등록하기"
        case .getSuggestion:
            return "추천받기"
        case .retry:
            return "다시뽑기"
        }
    }
}

// MARK: - ButtonStyle
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

// MARK: - Frame 기본값
struct PrimaryButtonDefaultFrame: ViewModifier {
    private let defaultHeight: CGFloat = 64
    
    func body(content: Content) -> some View {
        content
            .frame(height: defaultHeight)
    }
}

extension View {
    func primaryButtonDefaultFrame() -> some View {
        modifier(PrimaryButtonDefaultFrame())
    }
}

// MARK: - 프리뷰
#Preview {
    VStack {
        PrimaryButton("테스트") {
            print("버튼이 눌렸습니다.")
        }
        .primaryButtonDefaultFrame()
        
        PrimaryButton("테스트", disabled: true) {
            print("버튼이 눌렸습니다.")
        }
        .primaryButtonDefaultFrame()
        
        PrimaryButton(type: .findSchool) {
            print("버튼이 눌렸습니다.")
        }
        .primaryButtonDefaultFrame()
    }
}
