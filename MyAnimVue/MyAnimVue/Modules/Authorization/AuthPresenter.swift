//
//  AuthPresenter.swift
//  MyAnimVue
//
//  Created by Олег Романов on 03.07.2024.
//

import Foundation

final class AuthPresenter: AuthPresentationLogic {
    
    // MARK: Instance Properties
    
    weak var view: AuthViewDisplayLogic!
    var interactor: AuthBusinessLogic!
    var router: AuthRoutingLogic!
    
    // MARK: Instance Methods
    
    func shikimoriLoginButtonDidPress(urlString: String, from: NSObject) {
        interactor.setShikimoriWasCalled()
        router.routeToWebView(by: urlString, from: from)
    }
    
    func anilibriaLoginButtonDidPress(urlString: String, from: NSObject) {
        interactor.setAnilibriaWasCalled()
        router.routeToWebView(by: urlString, from: from)
    }
    
    func startButtonDidPress(isActive: Bool) {
        interactor.startButtonDidPress(isActive: isActive)
    }
    
    func processResult(isSuccess: Bool) {
        interactor.processResult(isSuccess: isSuccess)
    }
    
    func presentCheckmarkAnilibriaCircleView() {
        view.displayCheckmarkAnilibriaCircleView()
    }
    
    func presentCheckmarkShikimoriCircleView() {
        view.displayCheckmarkShikimoriCircleView()
    }
    
    func presentStartButtonActiveState() {
        view.displayStartButtonActiveState()
    }
    
    func presentError(with message: String) {
        view.displayErrorAlert(with: message)
    }
    
    func routeToTabbar() {
        router.routeToTabbar()
    }
}
