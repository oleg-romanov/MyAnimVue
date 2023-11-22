//
//  WebViewProtocols.swift
//  MyAnimVue
//
//  Created by Олег Романов on 31.10.2023.
//

import UIKit

protocol WebViewBusinessLogic: AnyObject {
    func saveSessionIdForAnilibria(with value: String)
    func saveTokensForShikimori(with value: String)
}

protocol WebViewPresentationLogic: AnyObject {
    func presentSuccess()
    func presentError()
}

protocol WebViewDisplayLogic: AnyObject {
    func displaySuccess()
    func displayErrorAlert()
}

protocol WebViewRoutingLogic: AnyObject {
    func dismissController(with completion: @escaping () -> Void)
    func dismissController()
    func presentController(viewController: UIViewController)
}
