//
//  KeychainService.swift
//  MyAnimVue
//
//  Created by Олег Романов on 15.10.2023.
//

import Foundation
import KeychainSwift

final class Keychain {
    
    private init() {}
    
    // MARK:  Properties
    
    public static let service = Keychain()
    
    private let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    
    // MARK:  Save Values
    
    func save(value: String, for key: String) -> Bool {
        return keychain.set(value, forKey: key)
    }
    
    func saveSessionId(value: String) -> Bool {
        return keychain.set(value, forKey: Keys.sessionId)
    }
    
    // MARK:  Get Values
    
    func getValue(for key: String) -> String? {
        return keychain.get(key)
    }
    
    func getSessionId() -> String? {
        return keychain.get(Keys.sessionId)
    }
    
    // MARK:  Get all keyes
    
    func getAllKeys() -> [String] {
        return keychain.allKeys
    }
    
    // MARK:  Delete values
    
    func deleteValue(for key: String) -> Bool {
        return keychain.delete(key)
    }
    
    func deleteSessionId() -> Bool {
        return keychain.delete(Keys.sessionId)
    }
    
    // MARK:  Delete all values from keychain
    
    func clearKeychain() -> Bool {
        return keychain.clear()
    }
}
