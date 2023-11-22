//
//  AuthorizationProtocols.swift
//  MyAnimVue
//
//  Created by Олег Романов on 13.10.2023.
//

protocol AuthorizationBusinessLogic: AnyObject {
    func saveSessionIdForAnilibria(with value: String)
    func saveTokensForShikimori()
}

protocol AuthorizationViewDisplayLogic: AnyObject {
    func displaySuccess()
    func displayErrorAlert(with message: String)
}

protocol AuthorizationRoutingLogic: AnyObject {
    func routeToTabbar()
    func routeToWebView(by urlString: String, from: AuthorizationViewController)
    
}
