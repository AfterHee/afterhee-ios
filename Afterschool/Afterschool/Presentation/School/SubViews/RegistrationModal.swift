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
                    }
                    
                    // 학교 아이콘 (주황색/갈색 톤)
                    Image(systemName: "building.2")
                        .font(.system(size: 48))
                        .foregroundColor(Color(red: 0.8, green: 0.4, blue: 0.2)) // 주황색/갈색 톤
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
                
                // 중앙 섹션 (질문)
                VStack(spacing: 20) {
                    // 질문 텍스트
                    Text("이 학교로 변경하시겠습니까?")
                        .font(.afBold16)
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
                    
                    // 변경하기 버튼
                    Button(action: onRegister) {
                        Text("변경하기")
                            .font(.afMedium16)
                            .foregroundColor(.afBlack)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.afWhite)
                            .cornerRadius(0)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .background(Color.afWhite)
            .cornerRadius(20)
            .padding(.horizontal, 20)
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
        RegistrationModal(
            school: School(
                id: "2",
                name: "애플디자인고등학교",
                address: "경상북도 포항시"
            ),
            onRegister: {
                print("변경하기 버튼 눌림!")
            },
            onDismiss: {
                print("X 버튼 눌림!")
            }
        )
        
        // 짧은 학교명, 긴 주소 예시
        RegistrationModal(
            school: School(
                id: "3",
                name: "애플중학교",
                address: "서울특별시 강남구 테헤란로 123길 45, 6층"
            ),
            onRegister: {
                print("변경하기 버튼 눌림!")
            },
            onDismiss: {
                print("X 버튼 눌림!")
            }
        )
        
        // 긴 학교명, 긴 주소 예시
        RegistrationModal(
            school: School(
                id: "4",
                name: "애플디자인고등학교",
                address: "서울특별시 강남구 테헤란로 123길 45, 6층"
            ),
            onRegister: {
                print("변경하기 버튼 눌림!")
            },
            onDismiss: {
                print("X 버튼 눌림!")
            }
        )
    }
}
