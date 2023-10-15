//
//  AuthPresenter.swift
//  MyAnimVue
//
//  Created by Олег Романов on 14.10.2023.
//

import Foundation

class AuthPresenter: AuthViewPresenter {
    
    // MARK:  Properties
    
    unowned let view: AuthView
    
    // MARK:  Initialize
    
    required init(view: AuthView) {
        self.view = view
    }
    
    func saveSessionId(with value: String) {
        let isSuccess = Keychain.service.saveSessionId(value: value)
        if (!isSuccess) {
            view.displayErrorAlert(with: "Произошла ошибка с сохранением токена")
        }
    }
}
