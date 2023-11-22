//
//  WebViewInteractor.swift
//  MyAnimVue
//
//  Created by Олег Романов on 31.10.2023.
//

import Foundation

final class WebViewInteractor: WebViewBusinessLogic {
    
    // MARK: - Instance Properties

    private let presenter: WebViewPresentationLogic
    
    // MARK: - Initializers
    
    init(presenter: WebViewPresentationLogic) {
        self.presenter = presenter
    }
    
    func saveSessionIdForAnilibria(with value: String) {
        let result = Keychain.service.saveAnilibSessionId(value: value)
        if (result) {
            presenter.presentSuccess()
        } else {
            presenter.presentError()
        }
    }
    
    func saveTokensForShikimori(with value: String) {
        let result = Keychain.service.saveShikimoriAuthCode(value: value)
        if (result) {
            presenter.presentSuccess()
        } else {
            presenter.presentError()
        }
    }
}
