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
    
    static let service = Keychain()
    
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
    
    func saveShikimoriTokens(accessToken: String, refreshToken: String) -> Bool {
        return saveShikimoriAccessToken(value: accessToken) && saveShikimoriRefreshToken(value: refreshToken)
    }
    
    func saveShikimoriAccessToken(value: String) -> Bool {
        return keychain.set(value, forKey: Keys.shikimoriAccessToken)
    }
    
    func saveShikimoriRefreshToken(value: String) -> Bool {
        return keychain.set(value, forKey: Keys.shikimoriRefreshToken)
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
    
    func getShikimoriAccessToken() -> String? {
        return keychain.get(Keys.shikimoriAccessToken)
    }
    
    func getShikimoriRefreshToken() -> String? {
        return keychain.get(Keys.shikimoriRefreshToken)
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
    
    func deleteShikimoriAccessToken() -> Bool {
        return keychain.delete(Keys.shikimoriAccessToken)
    }
    
    func deleteShikimoriRefreshToken() -> Bool {
        return keychain.delete(Keys.shikimoriRefreshToken)
    }
    
    func deleteShikimoriTokens() -> Bool {
        return deleteShikimoriAccessToken() && deleteShikimoriRefreshToken()
    }
    
    // MARK: Delete all values from keychain
    
    func clearKeychain() -> Bool {
        return keychain.clear()
    }
}
