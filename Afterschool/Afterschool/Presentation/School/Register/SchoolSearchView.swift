//
//  SchoolSearchView.swift
//  Afterschool
//
//  Created by SchoolSearchApp UI Integration
//

import SwiftUI
import Combine

/// 학교 검색 메인 뷰
/// Afterschool 디자인 시스템에 맞춰 구현
struct SchoolSearchView: View {
    // MARK: - Properties
    @StateObject private var viewModel = SchoolSearchViewModel()

    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // 검색바
                SearchBar(
                    text: $viewModel.searchText,
                    placeholder: "학교 검색"
                ) {
                    viewModel.searchSchools(query: viewModel.searchText)
                } onBack: {
                    // 뒤로가기 처리
                    print("Back tapped")
                }
                .padding(.top, 10)
                
                // 검색바 아래 구분선
                Rectangle()
                    .fill(Color.afGray100)
                    .frame(height: 2)
                    .padding(.top, 10)

                // 검색 결과 영역
                searchResultsView
            }
            .background(Color.afWhite)
            .navigationBarHidden(true)
            .toolbar(.hidden, for: .navigationBar)
        }
        .overlay(
            // 등록 모달 오버레이
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
        if viewModel.isLoading {
            // 로딩 상태
            Spacer()
            ProgressView()
                .progressViewStyle(.circular)
            Spacer()
        } else if viewModel.schools.isEmpty && !viewModel.searchText.isEmpty {
            // 검색 결과 없음
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
            // 검색 결과 목록
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.schools) { school in
                        SchoolRowView(
                            school: school,
                            searchText: viewModel.searchText,
                            isDisabled: viewModel.isSchoolCurrentlySelected(school)
                        ) {
                            viewModel.selectSchool(school)
                        }

                        // 구분선 (마지막 항목 제외)
                        if school.id != viewModel.schools.last?.id {
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

// MARK: - SchoolSearchViewModel (임시)
/// 학교 검색 뷰모델
/// TODO: Presentation 레이어의 ViewModel로 이동 필요
@MainActor
class SchoolSearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var schools: [School] = []
    @Published var isLoading = false
    @Published var selectedSchool: School?
    @Published var showRegistrationModal = false
    @Published var isRegistering = false
    
    // 현재 선택된 학교 (메인 뷰에서 전달받을 예정)
    @Published var currentSelectedSchool: School?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSearchDebounce()
        // 임시로 현재 선택된 학교 설정 (실제로는 메인 뷰에서 전달받음)
        currentSelectedSchool = School.mockSchools.first
    }
    
    private func setupSearchDebounce() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.searchSchools(query: query)
            }
            .store(in: &cancellables)
    }
    
    func searchSchools(query: String) {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            schools = []
            return
        }
        
        isLoading = true
        
        // 네트워크 지연 시뮬레이션
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            let filteredSchools = School.mockSchools.filter { school in
                school.name.localizedCaseInsensitiveContains(query) ||
                school.address.localizedCaseInsensitiveContains(query)
            }
            self?.schools = filteredSchools
            self?.isLoading = false
        }
    }
    
    func selectSchool(_ school: School) {
        // 현재 선택된 학교는 선택할 수 없음
        guard school.id != currentSelectedSchool?.id else {
            print("이미 선택된 학교입니다: \(school.name)")
            return
        }
        
        print("selectSchool called for: \(school.name)")
        selectedSchool = school
        showRegistrationModal = true
        print("showRegistrationModal set to: \(showRegistrationModal)")
    }
    
    func registerSchool() {
        guard let school = selectedSchool else { return }
        
        isRegistering = true
        
        // 등록 프로세스 시뮬레이션
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.isRegistering = false
            self?.showRegistrationModal = false
            self?.selectedSchool = nil
            // 등록 성공 시 현재 선택된 학교 업데이트
            self?.currentSelectedSchool = school
            print("Successfully registered: \(school.name)")
        }
    }
    
    func dismissModal() {
        showRegistrationModal = false
        selectedSchool = nil
    }
    
    /// 학교가 현재 선택된 학교인지 확인
    func isSchoolCurrentlySelected(_ school: School) -> Bool {
        return school.id == currentSelectedSchool?.id
    }
}

// MARK: - Preview
#Preview {
    SchoolSearchView()
}
