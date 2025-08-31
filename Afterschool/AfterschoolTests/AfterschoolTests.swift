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
    
    @Test func testDecodingErrorShowsBody() async {
        let network = Network()
        do {
            // 의도적으로 잘못된 타입으로 디코드 시도
            let _: BaseResponseDTO<[MealDTO]> = try await network.task(MainServerTarget.getSchool(keyword: "x"))
            #expect(Bool(false), "여기 오면 안 됨")
        } catch let e as NetworkError {
            switch e {
            case .decoding(_, let body):
                #expect(body != nil) // 원문 바디 보존 확인
            default:
                #expect(Bool(false), "decoding 에러가 나와야 함, but: \(e)")
            }
        } catch {
            #expect(Bool(false), "NetworkError가 나와야 함, but: \(error)")
        }
    }
}
