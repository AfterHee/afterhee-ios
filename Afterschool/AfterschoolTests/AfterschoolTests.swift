//
//  AfterschoolTests.swift
//  AfterschoolTests
//
//  Created by BoMin Lee on 8/19/25.
//

import Testing
@testable import Afterschool

struct AfterschoolTests {
    @Test func testGetSchool() async throws {
        let network = Network()
        let target: MainServerTarget = .getSchool(keyword: "포항제철")
        
        let response: BaseResponseDTO<[SchoolDTO]> = try await network.task(target)
        
        #expect(response.isError == false)
        #expect(!response.data.isEmpty)
        print("받은 학교 개수:", response.data.count)
        print("첫 번째 학교:", response.data.first?.schoolName ?? "nil")
    }
}
