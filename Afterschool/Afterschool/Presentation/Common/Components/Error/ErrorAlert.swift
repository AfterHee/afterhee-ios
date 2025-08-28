//
//  ErrorAlert.swift
//  Afterschool
//
//  Created by 임영택 on 8/28/25.
//

import SwiftUI

struct ErrorAlert: View {
    // MARK: - Properties
    let title: String
    let buttonTitle: String
    let action: () -> Void
    
    // MARK: - Constraints
    let outerRadius: CGFloat = 12
    let alertHeight: CGFloat = 233
    let emojiSize: CGFloat = 45
    let emojiTopPadding: CGFloat = 40
    let emojiBottomPadding: CGFloat = 24
    
    var body: some View {
        RoundedRectangle(cornerRadius: outerRadius, style: .circular)
            .foregroundStyle(Color.afWhite)
            .frame(height: alertHeight)
            .overlay {
                VStack(spacing: 0) {
                    Image(.alertEmoji)
                        .resizable()
                        .frame(width: emojiSize, height: emojiSize)
                        .padding(.top, emojiTopPadding)
                        .padding(.bottom, emojiBottomPadding)
                    
                    ErrorTitle(title: title)
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
                        Rectangle()
                            .foregroundStyle(Color.afGray100)
                            .frame(maxWidth: .infinity, maxHeight: 1)
                        
                        ErrorAlertOKButton(title: buttonTitle, action: action)
                    }
                }
            }
    }
}

struct ErrorAlertModifier: ViewModifier {
    let title: String
    let buttonTitle: String
    let action: () -> Void
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        if isPresented {
            content
                .overlay {
                    VStack {
                        Spacer()
                        
                        ErrorAlert(title: title, buttonTitle: buttonTitle) {
                            action()
                            isPresented.toggle() // 액션 수행 후 창을 닫는다
                        }
                        .padding(.horizontal, 16)
                        
                        Spacer()
                    }
                }
        } else {
            content
        }
    }
}

extension View {
    func errorAlert(
        title: String,
        buttonTitle: String,
        isPresented: Binding<Bool>,
        action: @escaping () -> Void
    ) -> some View {
        self.modifier(ErrorAlertModifier(title: title, buttonTitle: buttonTitle, action: action, isPresented: isPresented))
    }
    
    func errorAlert(title: String, buttonTitle: String, isPresented: Binding<Bool>) -> some View {
        self.modifier(
            ErrorAlertModifier(
                title: title,
                buttonTitle: buttonTitle,
                action: { },
                isPresented: isPresented
            )
        )
    }
}

#Preview {
    struct TestView: View {
        @State private var showAlert: Bool = false
        
        var body: some View {
            ZStack {
                Color.green
                
                VStack {
                    Spacer()
                    
                    Button("Show Alert") {
                        showAlert.toggle()
                    }
                    
                    Spacer()
                }
            }
            .errorAlert(title: "추천 메뉴를 불러오지 못했어요.", buttonTitle: "다시 시도하기", isPresented: $showAlert) {
                print("안녕안녕")
            }
        }
    }
    
    return TestView()
}
