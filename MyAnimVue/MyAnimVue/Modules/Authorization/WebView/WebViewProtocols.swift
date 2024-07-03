//
//  WebViewProtocols.swift
//  MyAnimVue
//
//  Created by Олег Романов on 31.10.2023.
//

import UIKit

protocol WebViewBusinessLogic: AnyObject {
    func saveSessionIdForAnilibria(with value: String)
    func saveTokenForShikimori(with value: String)
}

protocol WebViewPresentationLogic: AnyObject {
    func saveSessionIdForAnilibria(with value: String)
    func saveTokenForShikimori(with value: String)
    
    func presentSuccess()
    func presentError(with message: String)
    
    func dismissController()
    func presentController(controller: NSObject)
}

protocol WebViewDisplayLogic: AnyObject {
    func displaySuccess()
    func displayErrorAlert(with message: String)
}

protocol WebViewRoutingLogic: AnyObject {
    func dismissController()
    func presentController(controller: NSObject)
}
