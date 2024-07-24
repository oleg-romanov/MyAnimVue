//
//  Request.swift
//  MyAnimVue
//
//  Created by Олег Романов on 14.02.2024.
//

import Foundation

struct Request<Response>: @unchecked Sendable {
    var method: HTTPMethod
    var url: URL?
    var query: [String: String]?
    var body: Encodable?
    var headers: [String: String]?
    
    init(
        url: URL,
        method: HTTPMethod = .get,
        query: [String : String]? = nil,
        body: Encodable? = nil,
        headers: [String : String]? = nil
    ) {
        self.url = url
        self.method = method
        self.query = query
        self.body = body
        self.headers = headers
    }
    
    init(
        path: String,
        method: HTTPMethod = .get,
        query: [String : String]? = nil,
        body: Encodable? = nil,
        headers: [String : String]? = nil
    ) {
        self.url = URL(string: path.isEmpty ? "/" : path)
        self.method = method
        self.query = query
        self.body = body
        self.headers = headers
    }
}

struct HTTPMethod: RawRepresentable, Hashable, ExpressibleByStringLiteral {
    let rawValue: String
    
    init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
    
    static let get: HTTPMethod = "GET"
    static let post: HTTPMethod = "POST"
    static let put: HTTPMethod = "PUT"
    static let delete: HTTPMethod = "DELETE"
}
