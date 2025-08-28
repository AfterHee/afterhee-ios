//
//  UserDefaultsRepositoryProtocol.swift
//  Afterschool
//
//  Created by 임영택 on 8/28/25.
//

import Foundation

protocol UserDefaultsRepositoryProtocol {
    func save<T: Codable>(_ value: T, forKey key: UserDefaultStorageKey) throws
    func load<T: Codable>(_ type: T.Type, forKey key: UserDefaultStorageKey) -> T?
    func remove(forKey key: String)
}

enum UserDefaultStorageKey {
    case onboardingShown
    
    var stringKey: String {
        switch self {
        case .onboardingShown:
            return "onboardingShown"
        }
    }
}
