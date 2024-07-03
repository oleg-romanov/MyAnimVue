//
//  WebViewPresenter.swift
//  MyAnimVue
//
//  Created by Олег Романов on 01.11.2023.
//

import Foundation

final class WebViewPresenter: WebViewPresentationLogic {
    
    // MARK: Instance Properties
    
    weak var view: WebViewDisplayLogic!
    var interactor: WebViewBusinessLogic!
    var router: WebViewRoutingLogic!
    
    // MARK: Instance Methods
    
    func presentSuccess() {
        view.displaySuccess()
    }
    
    func presentError(with message: String) {
        view.displayErrorAlert(with: message)
    }
    
    func saveSessionIdForAnilibria(with value: String) {
        interactor.saveSessionIdForAnilibria(with: value)
    }
    
    func saveTokenForShikimori(with value: String) {
        interactor.saveTokenForShikimori(with: value)
    }
    
    func dismissController() {
        router.dismissController()
    }
    
    func presentController(controller: NSObject) {
        router.presentController(controller: controller)
    }
}
