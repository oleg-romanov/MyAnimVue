//
//  AuthEntities.swift
//  MyAnimVue
//
//  Created by Олег Романов on 24.07.2024.
//

import Foundation

// MARK: - TokenResponse

struct TokenResponse: Decodable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let refreshToken: String
    let scope: String
    let createdAt: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case scope
        case createdAt = "created_at"
    }
}
