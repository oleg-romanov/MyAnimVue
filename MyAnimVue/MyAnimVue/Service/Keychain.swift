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
    
    // MARK: Properties
    
    public static let service = Keychain()
    
    private let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    
    // MARK: Save Values
    
    func save(value: String, for key: String) -> Bool {
        return keychain.set(value, forKey: key)
    }
    
    func saveAnilibSessionId(value: String) -> Bool {
        return keychain.set(value, forKey: Keys.sessionId)
    }
    
    func saveShikimoriAuthCode(value: String) -> Bool {
        return keychain.set(value, forKey: Keys.shikimoriAuthCode)
    }
    
    // MARK: Get Values
    
    func getValue(for key: String) -> String? {
        return keychain.get(key)
    }
    
    func getAnilibSessionId() -> String? {
        return keychain.get(Keys.sessionId)
    }
    
    func getShikimoriAuthCode() -> String? {
        return keychain.get(Keys.shikimoriAuthCode)
    }
    
    // MARK: Get all keyes
    
    func getAllKeys() -> [String] {
        return keychain.allKeys
    }
    
    // MARK: Delete values
    
    func deleteValue(for key: String) -> Bool {
        return keychain.delete(key)
    }
    
    func deleteAnilibSessionId() -> Bool {
        return keychain.delete(Keys.sessionId)
    }
    
    func deleteShikimoriAuthCode() -> Bool {
        return keychain.delete(Keys.shikimoriAuthCode)
    }
    
    // MARK: Delete all values from keychain
    
    func clearKeychain() -> Bool {
        return keychain.clear()
    }
}
