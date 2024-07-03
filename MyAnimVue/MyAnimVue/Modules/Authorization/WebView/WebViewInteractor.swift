//
//  WebViewInteractor.swift
//  MyAnimVue
//
//  Created by Олег Романов on 31.10.2023.
//

import Foundation

final class WebViewInteractor: WebViewBusinessLogic {
    
    // MARK: Instance Properties

    weak var presenter: WebViewPresentationLogic!
    
    // MARK: Instance Methods
    
    func saveSessionIdForAnilibria(with value: String) {
        let result = Keychain.service.saveAnilibSessionId(value: value)
        check(result: result, from: "Anilibria")
    }
    
    func saveTokenForShikimori(with value: String) {
        let result = Keychain.service.saveShikimoriAuthCode(value: value)
        check(result: result, from: "Shikimori")
    }
    
    private func check(result: Bool, from: String) {
        result ? presenter.presentSuccess() : presenter.presentError(with: "An error occurred while saving the \(from) token.")
    }
}
