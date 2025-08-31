//
//  SchoolSearchViewModel.swift
//  Afterschool
//
//  Created by 산들 on 8/28/25.
//

import Foundation
import Combine
import os.log

// MARK: - SchoolSearchViewModel
/// 학교 검색 기능을 담당하는 ViewModel
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
    let getSchoolUseCase: GetSchoolUseCase
    let setSelectedSchoolUseCase: SetSelectedSchoolUseCase
    let getSelectedSchoolUseCase: GetSelectedSchoolUseCase
    
    // MARK: - State
    /// 현재 선택된 학교
    @Published var currentSelectedSchool: School?
    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    private let searchDebounceTime: TimeInterval = 0.5  // 디바운스 시간 증가로 API 호출 최적화
    private var currentSearchTask: Task<Void, Never>?  // 중복 요청 방지
    private let navigationRouter: NavigationRouter
    private let logger = Logger.makeOf("SchoolSearchViewModel")
    
    // MARK: - Initialization
    init(
        navigationRouter: NavigationRouter,
        getSchoolUseCase: GetSchoolUseCase,
        setSelectedSchoolUseCase: SetSelectedSchoolUseCase,
        getSelectedSchoolUseCase: GetSelectedSchoolUseCase
    ) {
        self.navigationRouter = navigationRouter
        self.getSchoolUseCase = getSchoolUseCase
        self.setSelectedSchoolUseCase = setSelectedSchoolUseCase
        self.getSelectedSchoolUseCase = getSelectedSchoolUseCase
        setupSearchDebounce()
        // 현재 선택된 학교 로드
        currentSelectedSchool = getSelectedSchoolUseCase.execute()
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
        // 빈 쿼리일 때는 검색하지 않음
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedQuery.isEmpty else {
            searchResults = []
            isSearchLoading = false
            searchErrorMessage = nil
            showSearchError = false
            return
        }
        
        // 이전 검색 작업 취소
        currentSearchTask?.cancel()
        
        isSearchLoading = true
        searchErrorMessage = nil
        showSearchError = false
        
        currentSearchTask = Task {
            do {
                let schools = try await getSchoolUseCase.execute(keyword: trimmedQuery)
                
                // data가 null인 경우 빈 결과로 처리
                
                // 작업이 취소되었는지 확인
                guard !Task.isCancelled else { return }
                
                await MainActor.run {
                    self.searchResults = schools
                    self.isSearchLoading = false
                    // 성공적인 응답이므로 에러 상태 초기화
                    self.searchErrorMessage = nil
                    self.showSearchError = false
                }
            } catch {
                // 작업이 취소되었는지 확인
                guard !Task.isCancelled else { return }
                
                await MainActor.run {
                    self.searchResults = []
                    self.isSearchLoading = false
                    self.searchErrorMessage = getErrorMessage(from: error)
                    self.showSearchError = true
                }
                print("Search error: \(error)")
            }
        }
    }
    
    /// 에러 메시지를 사용자 친화적으로 변환
    /// - Parameter error: 원본 에러
    /// - Returns: 사용자 친화적인 에러 메시지
    private func getErrorMessage(from error: Error) -> String {
        if let networkError = error as? NetworkError {
            return networkError.errorDescription ?? "학교 정보를 불러오지 못했어요."
        }
        
        // 일반적인 에러 처리
        return "학교 정보를 불러오지 못했어요."
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
        
        do {
            try setSelectedSchoolUseCase.execute(school: school)
            isRegistering = true
            navigationRouter.pop()
        } catch {
            logger.error("❌ failed to set selected school to UserDefaults")
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
        guard !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        searchSchools(query: searchText)
    }
    
    /// 학교가 현재 선택된 학교인지 확인
    /// - Parameter school: 확인할 학교
    /// - Returns: 현재 선택된 학교 여부
    func isSchoolCurrentlySelected(_ school: School) -> Bool {
        return school.id == currentSelectedSchool?.id
    }
}
