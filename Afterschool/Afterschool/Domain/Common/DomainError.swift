//
//  DomainError.swift
//  Afterschool
//
//  Created by 임영택 on 8/28/25.
//

import Foundation

enum DomainError: Error {
    case dataLayerError(cause: Error)
}

extension DomainError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .dataLayerError(cause: let cause):
            return "데이터 레이어 오류입니다. 원인 오류: \(cause.localizedDescription)"
        }
    }
}
