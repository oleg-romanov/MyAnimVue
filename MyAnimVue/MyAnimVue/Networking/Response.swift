//
//  Response.swift
//  MyAnimVue
//
//  Created by Олег Романов on 12.03.2024.
//

import Foundation

struct Response<T> {
    let value: T
    let response: URLResponse
    var statusCode: Int? { (response as? HTTPURLResponse)?.statusCode }
    let data: Data
    
    init(value: T, data: Data, response: URLResponse) {
        self.value = value
        self.data = data
        self.response = response
    }
    
    func map<E>(_ closure: (T) throws -> E) rethrows -> Response<E> {
        Response<E>(value: try closure(value), data: data, response: response)
    }
}

extension Response where T == URL {
    /// The location of the downloaded file. 
    var location: URL { value }
}

extension Response: @unchecked Sendable where T: Sendable {}
