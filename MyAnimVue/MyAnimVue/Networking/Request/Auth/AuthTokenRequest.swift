//
//  AuthTokenRequest.swift
//  MyAnimVue
//
//  Created by Олег Романов on 14.10.2023.
//

enum AuthTokenRequest: RequestProtocol {
    case auth
    
    var host: String {
        "https://zerkalo.anilib.top/"
    }

    var path: String {
        "pages/login.php"
    }

//    var params: [String: Any] {
//        [
//            "client_id": APIConstants.clientId,
//            "response_type": APIConstants.responseType
//        ]
//    }

    var addAuthorizationToken: Bool {
        false
    }

    var requestType: RequestType {
        .POST
    }
}
