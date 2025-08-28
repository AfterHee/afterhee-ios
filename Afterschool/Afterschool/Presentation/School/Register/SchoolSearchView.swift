//
//  SchoolSearchView.swift
//  Afterschool
//
//  Created by SchoolSearchApp UI Integration
//

import SwiftUI

/// 학교 검색 메인 뷰
struct SchoolSearchView: View {
    // MARK: - Properties
    @StateObject private var viewModel = SchoolSearchViewModel(searchSchoolUseCase: SearchSchoolUseCase(networkService: NetworkService()))

    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color.afGray100)
                    .frame(height: 2)
                    .padding(.top, 10)

                searchResultsView
            }
            .background(Color.afWhite)
            .navigationBarHidden(true)
            .toolbar(.hidden, for: .navigationBar)
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
}

// MARK: - Private Views
private extension SchoolSearchView {
    
    /// 검색 결과를 표시하는 뷰
    @ViewBuilder
    var searchResultsView: some View {
        if viewModel.isSearchLoading {
            Spacer()
            LoadingSearchView()
            Spacer()
        } else if viewModel.showSearchError {
            Spacer()
            ErrorSearchView(viewModel.searchErrorMessage ?? "학교 정보를 불러오지 못했어요.") {
                viewModel.retrySearch()
            }
            Spacer()
        } else if viewModel.searchResults.isEmpty && !viewModel.searchText.isEmpty {
            Spacer()
            VStack(spacing: 16) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 48))
                    .foregroundColor(.afGray400)

                Text("검색 결과가 없습니다")
                    .font(.afMedium16)
                    .foregroundColor(.afGray700)
            }
            Spacer()
        } else {
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
        }
    }
}

// MARK: - Preview
#Preview {
    SchoolSearchView()
}
