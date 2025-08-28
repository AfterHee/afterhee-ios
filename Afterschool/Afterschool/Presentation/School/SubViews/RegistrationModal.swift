//
//  RegistrationModal.swift
//  Afterschool
//
//  Created by SchoolSearchApp UI Integration
//

import SwiftUI

/// 학교 등록 확인 모달 컴포넌트
/// 이미지 디자인에 맞춰 정확히 구현
struct RegistrationModal: View {
    // MARK: - Properties
    let school: School
    let onRegister: () -> Void
    let onDismiss: () -> Void
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // 배경 오버레이 (흐릿한 배경)
            Color.afBlack.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }
            
            // 모달 컨텐츠
            VStack(spacing: 0) {
                // 상단 섹션
                VStack(spacing: 20) {
                    // 헤더 (X 버튼)
                    HStack {
                        Spacer()
                        Button(action: onDismiss) {
                            Image(systemName: "xmark")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.afBlack)
                        }
                        .padding(.trailing, -16)
                    }
                    
                    Image(.schoolIcon)
                        .padding(.bottom, 20)
                        
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
                
                // 중앙 섹션 (질문)
                VStack(spacing: 20) {
                    // 질문 텍스트
                    Text("이 학교로 변경하시겠습니까?")
                        .font(.afSemiBold18)
                        .foregroundColor(.afBlack)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                    
                    // 학교 정보 카드 (너비 자동 조절)
                    VStack(spacing: 8) {
                        Text(school.name)
                            .font(.afSemiBold17)
                            .foregroundColor(.afBlack)
                        
                        Text(school.address)
                            .font(.afRegular13)
                            .foregroundColor(.afGray700)
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 16)
                    .background(Color.afGray50)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 24)
                
                // 하단 섹션 (액션 버튼)
                VStack(spacing: 0) {
                    // 회색 구분선
                    Divider()
                        .background(Color.afGray100)
                        .padding(.top, 24)
                        .padding(.bottom, 20)
                    
                    // 변경하기 버튼
                    Button(action: onRegister) {
                        Text("변경하기")
                            .font(.afMedium16)
                            .foregroundColor(.afBlack)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 30)
                            .background(Color.afWhite)
                            .cornerRadius(0)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .background(Color.afWhite)
            .frame(width: 321, height: 321)
            .cornerRadius(12)
//            .padding(.horizontal, 20)
        }
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 20) {
        // 짧은 학교명, 짧은 주소 예시
        RegistrationModal(
            school: School(
                id: "1",
                name: "애플중학교",
                address: "경상북도 포항시"
            ),
            onRegister: {
                print("변경하기 버튼 눌림!")
            },
            onDismiss: {
                print("X 버튼 눌림!")
            }
        )
        
        // 긴 학교명, 짧은 주소 예시
//        RegistrationModal(
//            school: School(
//                id: "2",
//                name: "애플디자인고등학교",
//                address: "경상북도 포항시"
//            ),
//            onRegister: {
//                print("변경하기 버튼 눌림!")
//            },
//            onDismiss: {
//                print("X 버튼 눌림!")
//            }
//        )
        
        // 짧은 학교명, 긴 주소 예시
//        RegistrationModal(
//            school: School(
//                id: "3",
//                name: "애플중학교",
//                address: "서울특별시 강남구 테헤란로 123길 45, 6층"
//            ),
//            onRegister: {
//                print("변경하기 버튼 눌림!")
//            },
//            onDismiss: {
//                print("X 버튼 눌림!")
//            }
//        )
        
        // 긴 학교명, 긴 주소 예시
//        RegistrationModal(
//            school: School(
//                id: "4",
//                name: "애플디자인고등학교",
//                address: "서울특별시 강남구 테헤란로 123길 45, 6층"
//            ),
//            onRegister: {
//                print("변경하기 버튼 눌림!")
//            },
//            onDismiss: {
//                print("X 버튼 눌림!")
//            }
//        )
    }
}
