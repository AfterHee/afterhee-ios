//
//  LoadingCard.swift
//  Afterschool
//
//  Created by 임영택 on 8/26/25.
//

import SwiftUI

struct LoadingCard: View {
    // MARK: - State
    /// 추천 음식 이름. 아직 로딩중이면 nil. 세팅이 되면 애니메이션 중지를 기다리고 노출된다.
    /// Task 내부에서 이 값을 바라보며 루프를 돌기 때문에 값이 캡쳐되면 안되고 외부에서 관리되어야 한다. 따라서 Binding으로 취급
    @Binding var recommendation: String?
    
    /// 현재 애니메이션 상태. offset 값을 가지고 있다
    @State private var animationState: LoadingCardAnimationState = .zero
    
    /// 반복 애니메이션을 위한 Task. 조건에 따라 중간에 멈춰야하기 때문에 repeat하지 않고 Task로 재시작한다.
    @State private var floatingTask: Task<Void, Never>? = nil
    
    /// 실제로 표시되는 추천 음식 이름.
    @State private var showingRecommendation: String? = nil
    
    /// 애니메이션이 멈췄는지 여부.
    /// 처음 뷰가 뜨면 애니메이션이 바로 시작되므로 초깃값 false
    @State private var animationStopped = false
    
    // MARK: - Computed Properties
    private var imageResource: ImageResource {
        showingRecommendation == nil ? .loadingCard : .resultCard
    }
    
    private var isCardActive: Bool {
        if let showingRecommendation,
           !showingRecommendation.isEmpty {
            return true
        }
        return false
    }
    
    // MARK: - Constraints
    private let baseCardSize: CGSize = .init(width: 189, height: 249)
    private let deactivatedImageScale: CGFloat = 0.9
    private let animationDuration: Double = 1.0
    
    var body: some View {
        ZStack {
            // TODO: 여기에 배경 모션
            
            Image(imageResource)
                .resizable()
                .scaledToFit()
            
            if let showingRecommendation {
                CardFowardSide(recommendation: showingRecommendation)
            }
        }
            .frame(width: baseCardSize.width, height: baseCardSize.height)
            .scaleEffect(isCardActive ? 1.0 : deactivatedImageScale)
            .offset(y: animationState.yOffset)
            .onAppear {
                startFloat()
            }
            .onChange(of: animationStopped) { _, isStopped in // 애니메이션 중단 후
                if isStopped {
                    withAnimation {
                        showingRecommendation = recommendation
                    }
                }
            }
    }
}

extension LoadingCard {
    // MARK: - Animation 관련 로직
    
    // [애니메이션 플로우]
    // onAppear -> 애니메이션 시작
    // recommendation 변경 && nil 아님 -> 애니메이션 중지
    // isStopped 변경 && true임 -> 배경 카드 이미지 변경 + recommendation 스트링 노출
    
    private func startFloat() {
        floatingTask?.cancel()
        floatingTask = Task {
            while !Task.isCancelled {
                if recommendation != nil {
                    withAnimation(.easeInOut(duration: animationDuration)) { @MainActor in
                        animationState = .zero
                    } completion: {
                        print("completed")
                        stopFloat()
                    }
                    return
                }
                
                withAnimation(.easeInOut(duration: animationDuration)) { @MainActor in
                    self.animationState = animationState.nextStep
                }
                
                try? await Task.sleep(nanoseconds: UInt64(animationDuration * 1_000_000_000))
            }
        }
    }
    
    private func stopFloat() {
        floatingTask?.cancel()
        animationStopped = true
    }
}

fileprivate enum LoadingCardAnimationState {
    case up
    case zero
    
    var yOffset: CGFloat {
        switch self {
        case .up:
            return -80
        case .zero:
            return 0
        }
    }
    
    var nextStep: LoadingCardAnimationState {
        switch self {
        case .up:
            return .zero
        case .zero:
            return .up
        }
    }
}

#Preview {
    struct LoadingCardConatiner: View {
        @State var recommendation: String? = nil
        
        var body: some View {
            VStack {
                Spacer()
                
                Button("토글") {
                    recommendation = "안녕프란체스카프란체스카프란체스카"
                }
                
                Spacer()
                
                LoadingCard(recommendation: $recommendation)
            }
        }
    }
    
    return LoadingCardConatiner()
}
