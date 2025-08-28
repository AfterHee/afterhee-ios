//
//  SchoolRegisterView.swift
//  Afterschool
//
//  Created by 산들 on 8/28/25.
//

import SwiftUI

/// 학교 등록 기능 뷰 (검색바가 NavigationBar와 함께 있는 구조)
struct SchoolRegisterView: View {
    @StateObject private var viewModel = SchoolSearchViewModel(getSchoolUseCase: GetSchoolUseCase())
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // 구분선
                Rectangle()
                    .fill(Color.afGray100)
                    .frame(height: 8)
                
                // 검색 결과
                searchResultsView
            }
            .background(Color.afWhite)
            .afNavigationBar(centerView: searchBarInNavigationBar)
        }
        .overlay(
            Group {
                if viewModel.showRegistrationModal,
                   let selectedSchool = viewModel.selectedSchool {
                    RegistrationModal(
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
    
    /// NavigationBar에 포함될 검색바
    private var searchBarInNavigationBar: some View {
        SearchBar(
            searchText: $viewModel.searchText,
            placeholder: "학교 검색"
        )
        .frame(maxWidth: 326)
        .padding(.leading, 30)
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
#Preview("학교 등록") {
    SchoolRegisterView()
}
