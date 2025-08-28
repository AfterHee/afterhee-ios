//
//  NetworkError.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/28/25.
//

import Foundation
import Moya

enum NetworkError: Error, LocalizedError {
    case transport(MoyaError)
    case cancelled
    case timeout
    case noConnection
    case httpStatus(code: Int, message: String?, body: String?)
    case server(message: String, code: Int?)
    case decoding(underlying: Error, body: String?)
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .transport(let e): return "네트워크 오류: \(e.localizedDescription)"
        case .cancelled:        return "요청이 취소되었습니다."
        case .timeout:          return "요청 시간이 초과되었습니다."
        case .noConnection:     return "네트워크에 연결할 수 없습니다."
        case .httpStatus(let code, let message, _):
            return message ?? "서버 응답 오류 (\(code))"
        case .server(let msg, _): return msg
        case .decoding:         return "응답 파싱에 실패했습니다."
        case .invalidResponse:  return "유효하지 않은 서버 응답입니다."
        }
    }
}

struct ServerCommonErrorDTO: Decodable {
    let isError: Bool?
    let message: String?
}
