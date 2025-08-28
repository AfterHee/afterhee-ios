//
//  SchoolSearchViewModel.swift
//  Afterschool
//
//  Created by 산들 on 8/28/25.
//

import Foundation
import Combine

// MARK: - SchoolSearchViewModel
/// 학교 검색 기능을 담당하는 ViewModel
@MainActor
class SchoolSearchViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var searchText = ""
    @Published var searchResults: [School] = []
    @Published var isSearchLoading = false
    @Published var searchErrorMessage: String?
    @Published var showSearchError = false
    @Published var selectedSchool: School?
    @Published var showRegistrationModal = false
    @Published var isRegistering = false
    
    // MARK: - Dependencies
    let searchSchoolUseCase: SearchSchoolUseCase
    
    // MARK: - State
    /// 현재 선택된 학교 (메인 뷰에서 전달받을 예정)
    @Published var currentSelectedSchool: School?
    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    private let searchDebounceTime: TimeInterval = 0.3
    private let minSearchLength = 1
    
    // MARK: - Initialization
    init(searchSchoolUseCase: SearchSchoolUseCase) {
        self.searchSchoolUseCase = searchSchoolUseCase
        setupSearchDebounce()
        currentSelectedSchool = School.mockSchools.first
    }
    
    // MARK: - Private Methods
    private func setupSearchDebounce() {
        $searchText
            .debounce(for: .milliseconds(Int(searchDebounceTime) * 1000), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.searchSchools(query: query)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Public Methods
    
    /// 학교 검색 실행
    /// - Parameter query: 검색할 키워드
    func searchSchools(query: String) {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedQuery.isEmpty && trimmedQuery.count >= minSearchLength else {
            searchResults = []
            return
        }
        
        isSearchLoading = true
        searchErrorMessage = nil
        showSearchError = false
        
        Task {
            do {
                let results = try await searchSchoolUseCase.execute(keyword: trimmedQuery)
                await MainActor.run {
                    self.searchResults = results
                    self.isSearchLoading = false
                }
            } catch {
                await MainActor.run {
                    self.searchResults = []
                    self.isSearchLoading = false
                    self.searchErrorMessage = error.localizedDescription
                    self.showSearchError = true
                }
                print("Search error: \(error)")
            }
        }
    }
    
    /// 학교 선택 처리
    /// - Parameter school: 선택된 학교
    func selectSchool(_ school: School) {
        guard school.id != currentSelectedSchool?.id else {
            print("이미 선택된 학교입니다: \(school.name)")
            return
        }
        
        print("selectSchool called for: \(school.name)")
        selectedSchool = school
        showRegistrationModal = true
        print("showRegistrationModal set to: \(showRegistrationModal)")
    }
    
    /// 학교 등록 처리
    func registerSchool() {
        guard let school = selectedSchool else { return }
        
        isRegistering = true
        
        // TODO: - Actual Registration API Call
        // 실제 등록 API 호출로 변경
        // - API 엔드포인트 구현
        // - 성공/실패 처리
        // - 에러 핸들링
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.isRegistering = false
            self?.showRegistrationModal = false
            self?.selectedSchool = nil
            self?.currentSelectedSchool = school
            print("Successfully registered: \(school.name)")
        }
    }
    
    /// 모달 닫기 처리
    func dismissModal() {
        showRegistrationModal = false
        selectedSchool = nil
    }
    
    /// 검색 에러 상태 초기화
    func dismissSearchError() {
        showSearchError = false
        searchErrorMessage = nil
    }
    
    /// 검색 재시도
    func retrySearch() {
        searchSchools(query: searchText)
    }
    
    /// 학교가 현재 선택된 학교인지 확인
    /// - Parameter school: 확인할 학교
    /// - Returns: 현재 선택된 학교 여부
    func isSchoolCurrentlySelected(_ school: School) -> Bool {
        return school.id == currentSelectedSchool?.id
    }
}
