//
//  Network.swift
//  Afterschool
//
//  Created by 임영택 on 8/24/25.
//  Edited by BoMin Lee on 8/28/25.
//

import Foundation
import Moya

class Network {
    func task<T: Decodable, E: TargetType>(_ target: E) async throws -> T {
        let provider: MoyaProvider<E> = .init()
        let result = await provider.request(target)
        let parsed = self.handleResult(T.self, result: result)
        
        switch parsed {
        case .success(let response):
            return response
        case .failure(let moyaError):
            throw moyaError
        }
    }
    
    private func handleResult<T: Decodable>(_ type: T.Type, result: Result<Moya.Response, MoyaError>) -> Result<T, MoyaError> {
        switch result {
        case .success(let response):
            if let data = try? JSONDecoder().decode(type, from: response.data) {
                return .success(data)
            } else {
                print("Decode Error - Original Data: \(response)")
                return .failure(.jsonMapping(response))
            }
        case .failure(let moyaError):
            print("Network Error: \(moyaError)")
            return .failure(moyaError)
        }
    }
}
