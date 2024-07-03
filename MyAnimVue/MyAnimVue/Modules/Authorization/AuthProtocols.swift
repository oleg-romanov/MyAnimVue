//
//  AuthProtocols.swift
//  MyAnimVue
//
//  Created by Олег Романов on 13.10.2023.
//

import Foundation

protocol AuthPresentationLogic: AnyObject {
    func shikimoriLoginButtonDidPress(urlString: String, from: NSObject)
    func anilibriaLoginButtonDidPress(urlString: String, from: NSObject)
    func startButtonDidPress(isActive: Bool)
    
    func processResult(isSuccess: Bool)
    
    func presentCheckmarkAnilibriaCircleView()
    func presentCheckmarkShikimoriCircleView()
    func presentStartButtonActiveState()
    
    func routeToTabbar()
}

protocol AuthBusinessLogic: AnyObject {
    func setAnilibriaWasCalled()
    func setShikimoriWasCalled()
    func processResult(isSuccess: Bool)
    func startButtonDidPress(isActive: Bool)
}

protocol AuthViewDisplayLogic: AnyObject {
    func displayErrorAlert(with message: String)
    
    func displayCheckmarkAnilibriaCircleView()
    func displayCheckmarkShikimoriCircleView()
    func displayStartButtonActiveState()
}

protocol AuthRoutingLogic: AnyObject {
    func routeToTabbar()
    func routeToWebView(by urlString: String, from: NSObject)
}
