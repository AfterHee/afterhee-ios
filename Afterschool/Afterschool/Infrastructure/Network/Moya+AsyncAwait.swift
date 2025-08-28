//
//  Moya+AsyncAwait.swift
//  Afterschool
//
//  Created by 임영택 on 8/24/25.
//  Edited by BoMin Lee on 8/28/25.
//

import Foundation
import Moya

extension MoyaProvider {
    func request(
        _ target: Target,
        callbackQueue: DispatchQueue? = .none,
        progress: ProgressBlock? = .none
    ) async -> Result<Moya.Response, MoyaError> {
        await withCheckedContinuation { continuation in
            self.request(
                target,
                callbackQueue: callbackQueue,
                progress: progress,
            ) { result in
                continuation.resume(returning: result)
            }
        }
    }
}
