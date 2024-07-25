//
//  APIClientDelegate.swift
//  MyAnimVue
//
//  Created by Олег Романов on 24.07.2024.
//

import Foundation

protocol APIClientDelegate: AnyObject {
    func client(_ client: APIClient, willSendRequest request: inout URLRequest) async throws
}

extension APIClientDelegate {
    func client(_ client: APIClient, willSendRequest request: inout URLRequest) async throws {}
}

class APIDelegate: APIClientDelegate {
    func client(_ client: APIClient, willSendRequest request: inout URLRequest) async throws {
        let accessToken: String = Keychain.service.getShikimoriAccessToken() ?? ""
        
        request.setValue("MyAnimVue", forHTTPHeaderField: "User-Agent")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    }
}
