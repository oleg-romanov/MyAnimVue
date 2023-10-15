//
//  AuthProtocols.swift
//  MyAnimVue
//
//  Created by Олег Романов on 13.10.2023.
//

protocol AuthView: AnyObject {
    func displayErrorAlert(with message: String)
}

protocol AuthViewPresenter {
    func saveSessionId(with value: String)
}

protocol AuthRoutingLogic {
    func routeToTabbar()
}
