//
//  RegistrationModal.swift
//  Afterschool
//
//  Created by Sandeul
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
            Color.afBlack.opacity(0.2)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }
            
            // 모달 컨텐츠
            VStack {
                HStack {
                    Spacer()
                    Button(action: onDismiss) {
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.afGray600)
                    }
                }
                .padding(.top, 16)
                .padding(.trailing, 16)
                
                Image(.schoolIcon)
                
                Spacer().frame(height: 20)
                
                // TODO: 등록/변경 분기 필요
                Text("이 학교로 변경하시겠습니까?")
                    .font(.afSemiBold18)
                    .lineHeight(1.5, fontSize: 18)
                    .foregroundColor(.afBlack)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                Spacer().frame(height: 24)
                // 학교 정보 카드 (너비 자동 조절)
                VStack(spacing: 3) {
                    Text(school.name)
                        .font(.afSemiBold17)
                        .lineHeight(1.5, fontSize: 17)
                        .foregroundColor(.afBlack)
                    Text(school.address)
                        .font(.afRegular13)
                        .lineHeight(1.2, fontSize: 13)
                        .foregroundColor(.afBlack)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .background(Color.afGray50)
                .cornerRadius(12)
                Spacer().frame(height: 24)
                
                Divider()
                    .background(Color.afGray100)
                // 변경하기 버튼
                Button(action: onRegister) {
                    VStack {
                        Spacer().frame(height: 20)
                        Text("변경하기")
                            .font(.afMedium16)
                            .foregroundColor(.afGray600)
                        Spacer().frame(height: 20)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .background(Color.afWhite)
            .cornerRadius(12)
            .padding(.horizontal, 36)
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
