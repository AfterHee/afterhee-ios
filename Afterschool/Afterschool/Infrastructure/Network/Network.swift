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
    private let decoder: JSONDecoder
        
    init(
        decoder: JSONDecoder = {
            let d = JSONDecoder()
            d.keyDecodingStrategy = .useDefaultKeys
            return d
        }()
    ) {
        self.decoder = decoder
    }
    
    func task<T: Decodable, E: TargetType>(_ target: E) async throws -> T {
        let provider: MoyaProvider<E> = .init()
        let result = await provider.request(target)
        return try handleResult(T.self, result: result)
//        let parsed = self.handleResult(T.self, result: result)
//        
//        switch parsed {
//        case .success(let response):
//            return response
//        case .failure(let moyaError):
//            throw moyaError
//        }
    }
    
    private func handleResult<T: Decodable>(_ type: T.Type, result: Result<Moya.Response, MoyaError>) throws -> T {
        switch result {
        case .success(let response):
//            if let data = try? JSONDecoder().decode(type, from: response.data) {
//                return .success(data)
//            } else {
//                print("Decode Error - Original Data: \(response)")
//                return .failure(.jsonMapping(response))
//            }
            let status = response.statusCode
            let rawBody = String(data: response.data, encoding: .utf8)
            
            guard (200...299).contains(status) else {
                let serverMsg = (try? decoder.decode(ServerCommonErrorDTO.self, from: response.data))?.message
                throw NetworkError.httpStatus(code: status, message: serverMsg, body: rawBody)
            }
            
            do {
                let decoded = try decoder.decode(T.self, from: response.data)
                
                if let envelope = decoded as? HasCommonFields, envelope.isError {
                    throw NetworkError.server(message: envelope.message, code: status)
                }
                
                return decoded
            } catch {
                throw NetworkError.decoding(underlying: error, body: rawBody)
            }
        case .failure(let moyaError):
            throw mapTransportError(moyaError)
        }
    }
    
    private func mapTransportError(_ e: MoyaError) -> NetworkError {
        if case let .underlying(under, _) = e,
           let nsErr = under as NSError? {
            switch nsErr.code {
            case NSURLErrorCancelled:          return .cancelled
            case NSURLErrorTimedOut:           return .timeout
            case NSURLErrorNotConnectedToInternet,
                NSURLErrorNetworkConnectionLost: return .noConnection
            default: break
            }
        }
        return .transport(e)
    }
}
