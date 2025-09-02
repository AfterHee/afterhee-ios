//
//  NavigationBar.swift
//  Afterschool
//
//  Created by 임영택 on 8/25/25.
//

import SwiftUI

/// 주어진 뷰를 VStack으로 감싸고, 상단에 커스텀 네비게이션 바를 붙이는 뷰 모디파이어
///
/// - Parameters:
///   - centerView: 네비게이션 바의 중앙에 표시할 커스텀 뷰 (예: 텍스트, 로고 등)
///   - inversed: 네비게이션 바 색상 반전 여부. `true`면 어두운 배경/흰색 아이콘, `false`면 밝은 배경/검정 아이콘
struct NavigationBar<CenterView>: ViewModifier where CenterView: View {
    @Environment(\.dismiss) var dismiss
    
    /// MARK: - Properties
    let centerView: CenterView
    let inversed: Bool
    
    /// MARK: - Constraints
    private let backButtonImageWidth: CGFloat = 15
    private let backButtonImageHeight: CGFloat = 21
    private let navBarHeight: CGFloat = 60
    private let navBarInnerBottomPadding: CGFloat = 12
    private let horizontalPadding: CGFloat = 18
    private let inversedBackgroundColor: Color = Color(hex: "545454")
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                // 좌측 백 버튼
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(!inversed ? Color.afBlack : Color.afWhite)
                            .frame(width: backButtonImageWidth, height: backButtonImageHeight)
                    }
                    Spacer()
                }
                .frame(height: navBarHeight - navBarInnerBottomPadding)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, horizontalPadding)
                
                // 중앙 뷰
                HStack {
                    Spacer()
                    centerView
                    Spacer()
                }
                .frame(height: navBarHeight - navBarInnerBottomPadding)
            }
            .frame(height: navBarHeight, alignment: .top)
            .background(!inversed ? Color.afWhite : inversedBackgroundColor)
            .background(!inversed ? Color.afWhite : inversedBackgroundColor)
            .ignoresSafeArea(.all, edges: .horizontal)
            .ignoresSafeArea(.all, edges: .bottom)
            
            content
                .toolbar(.hidden)
        }
    }
}

extension View {
    func afNavigationBar<CenterView>(centerView: CenterView, inversed: Bool = false) -> some View where CenterView: View {
        return modifier(NavigationBar(centerView: centerView, inversed: inversed))
    }
    
    func afNavigationBar(title: String, inversed: Bool = false) -> some View {
        let titleLabel = Text(title)
            .font(.afSemiBold17)
            .foregroundStyle(Color.afBlack)
        
        return modifier(NavigationBar(
            centerView: titleLabel,
            inversed: inversed
        ))
    }
    
    func afNavigationBar(inversed: Bool = false) -> some View {
        return modifier(NavigationBar(
            centerView: EmptyView(),
            inversed: inversed
        ))
    }
}

/// 상단 네비게이션바를 숨기면 스와이프로 뒤로가기가 안되는 문제를 해결
// CAUTION: 외부 모듈(UIKit)의 프로토콜 UINavigationController을 바로 확장해서 경고 발생
// TODO: 추후 하위타입으로 구현하는 방식 고려
extension UINavigationController: UIGestureRecognizerDelegate {
    fileprivate static var isGestureDisabled: Bool = false
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1 && !UINavigationController.isGestureDisabled
    }
}

#Preview {
    let demoCenterView = RoundedRectangle(cornerRadius: 8, style: .circular)
        .foregroundStyle(Color.afGray50)
        .padding(.leading, 51)
        .padding(.trailing, 16)
        .frame(height: 44)
    
    let destinationView = VStack {
        Spacer()
        Text("contentView")
        Spacer()
    }
        .afNavigationBar(centerView: demoCenterView)
    //        .afNavigationBar(title: "학교 변경하기")
    
    NavigationStack {
        NavigationLink("하이") {
            destinationView
        }
    }
}
