//
//  SchoolSearchChangeView.swift
//  Afterschool
//
//  Created by SchoolSearchApp UI Integration
//
// TODO: 학교 등록/변경에 따른 엔티티 변경 작업 필요
import SwiftUI

/// 학교 변경 기능 뷰
struct SchoolSearchChangeView: View {
    @StateObject private var viewModel = SchoolSearchViewModel(getSchoolUseCase: GetSchoolUseCase())
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // 검색바
                SearchBar(
                    searchText: $viewModel.searchText,
                    placeholder: "학교 검색"
                )
                .padding(.horizontal, 20)
                .padding(.top, -5)
                .padding(.bottom, 20)
                
                // 구분선
                Rectangle()
                    .fill(Color.afGray50)
                    .frame(height: 8)
                
                // 검색 결과
                searchResultsView
            }
            .background(Color.afWhite)
            .afNavigationBar(title: "학교 변경하기")
        }
        .overlay(
            Group {
                if viewModel.showRegistrationModal,
                   let selectedSchool = viewModel.selectedSchool {
                    RegistrationChangeModal(
                        school: selectedSchool,
                        onRegister: {
                            viewModel.registerSchool()
                        },
                        onDismiss: {
                            viewModel.dismissModal()
                        }
                    )
                }
            }
        )
    }
    
    /// 검색 결과를 표시하는 뷰
    @ViewBuilder
    private var searchResultsView: some View {
        if viewModel.isSearchLoading {
            Spacer()
            LoadingSearchView()
            Spacer()
        } else if viewModel.showSearchError {
            Spacer()
            ErrorSearchView(errorMessage: viewModel.searchErrorMessage ?? "학교 정보를 불러오지 못했어요.") {
                viewModel.retrySearch()
            }
            Spacer()
        } else if !viewModel.searchText.isEmpty && viewModel.searchResults.isEmpty {
            Spacer()
            VStack(spacing: 16) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 48))
                    .foregroundColor(.afGray400)

                Text("검색어와 일치하는 학교가 없습니다.")
                    .font(.afMedium16)
                    .foregroundColor(.afGray700)
            }
            Spacer()
        } else if !viewModel.searchResults.isEmpty {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.searchResults) { school in
                        SchoolRowView(
                            school: school,
                            searchText: viewModel.searchText,
                            isDisabled: viewModel.isSchoolCurrentlySelected(school)
                        ) {
                            viewModel.selectSchool(school)
                        }

                        if school.id != viewModel.searchResults.last?.id {
                            Divider()
                                .background(Color.afGray100)
                                .padding(.horizontal, 20)
                        }
                    }
                }
            }
        } else {
            // 아무것도 입력하지 않았을 때는 빈 화면
            Spacer()
        }
    }
}



// MARK: - Preview
#Preview {
    SchoolSearchChangeView()
}
