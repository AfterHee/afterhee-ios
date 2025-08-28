//
//  UserDefaultsRepository.swift
//  Afterschool
//
//  Created by 임영택 on 8/28/25.
//

import Foundation

final class UserDefaultsRepository: UserDefaultsRepositoryProtocol {
    private let storage: UserDefaultsStorageProtocol
    
    init(storage: UserDefaultsStorageProtocol) {
        self.storage = storage
    }
    
    func save<T>(_ value: T, forKey key: UserDefaultStorageKey) throws where T : Decodable, T : Encodable {
        try storage.save(value, forKey: key.stringKey)
    }
    
    func load<T>(_ type: T.Type, forKey key: UserDefaultStorageKey) -> T? where T : Decodable, T : Encodable {
        storage.load(type, forKey: key.stringKey)
    }
    
    func remove(forKey key: String) {
        storage.remove(forKey: key)
    }
}
