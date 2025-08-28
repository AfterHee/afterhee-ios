//
//  UserDefaultStorage.swift
//  Afterschool
//
//  Created by 임영택 on 8/28/25.
//

import Foundation
import os.log

protocol UserDefaultsStorageProtocol {
    func save<T: Codable>(_ value: T, forKey key: UserDefaultStorageKey) throws
    func load<T: Codable>(_ type: T.Type, forKey key: UserDefaultStorageKey) -> T?
    func remove(forKey key: UserDefaultStorageKey)
}

final class UserDefaultsStorage: UserDefaultsStorageProtocol {
    private let userDefaults: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    private let logger = Logger.makeOf("UserDefaultsStorage")
    
    init(userDefaults: UserDefaults = .standard,
         encoder: JSONEncoder = JSONEncoder(),
         decoder: JSONDecoder = JSONDecoder()) {
        self.userDefaults = userDefaults
        self.encoder = encoder
        self.decoder = decoder
        // 전략이 필요하면 설정: encoder.dateEncodingStrategy = .iso8601 등
    }
    
    func save<T>(_ value: T, forKey key: UserDefaultStorageKey) throws where T: Codable {
        switch value {
        case let v as String:
            userDefaults.set(v, forKey: key.stringKey)
        case let v as Int:
            userDefaults.set(v, forKey: key.stringKey)
        case let v as Bool:
            userDefaults.set(v, forKey: key.stringKey)
        case let v as Double:
            userDefaults.set(v, forKey: key.stringKey)
        case let v as Float:
            userDefaults.set(v, forKey: key.stringKey)
        case let v as Data:
            userDefaults.set(v, forKey: key.stringKey)
        case let v as Date:
            userDefaults.set(v, forKey: key.stringKey)
        case let v as URL:
            userDefaults.set(v, forKey: key.stringKey)
        default:
            // 나머지는 JSON으로 인코딩해서 Data로 저장
            do {
                let data = try encoder.encode(value)
                userDefaults.set(data, forKey: key.stringKey)
            } catch {
                logger.error("UserDefaultsStorage.encode failed for key '\(key.stringKey)': \(error)")
                throw UserDefaultStorageError.encodingFailed
            }
        }
    }
    
    func load<T>(_ type: T.Type, forKey key: UserDefaultStorageKey) -> T? where T: Codable {
        if T.self == String.self { return userDefaults.string(forKey: key.stringKey) as? T }
        if T.self == Int.self    { return (userDefaults.object(forKey: key.stringKey) as? Int) as? T }
        if T.self == Bool.self   { return (userDefaults.object(forKey: key.stringKey) as? Bool) as? T }
        if T.self == Double.self { return (userDefaults.object(forKey: key.stringKey) as? Double) as? T }
        if T.self == Float.self  { return (userDefaults.object(forKey: key.stringKey) as? Float) as? T }
        if T.self == Data.self   { return userDefaults.data(forKey: key.stringKey) as? T }
        if T.self == Date.self   { return (userDefaults.object(forKey: key.stringKey) as? Date) as? T }
        if T.self == URL.self    { return userDefaults.url(forKey: key.stringKey) as? T }
        
        // 다른 타입들은 JSON 디코딩 시도
        guard let data = userDefaults.data(forKey: key.stringKey) else { return nil }
        
        do {
            let decodedValue = try decoder.decode(type, from: data)
            return decodedValue
        } catch {
            // 디코딩 실패
            logger.error("UserDefaultsStorage.decode failed for key '\(key.stringKey)': \(error)")
            return nil
        }
    }
    
    func remove(forKey key: UserDefaultStorageKey) {
        userDefaults.removeObject(forKey: key.stringKey)
    }
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

enum UserDefaultStorageError: LocalizedError {
    case encodingFailed
    
    var errorDescription: String? {
        switch self {
        case .encodingFailed:
            return "Encoding failed"
        }
    }
}
