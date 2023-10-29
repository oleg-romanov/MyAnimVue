//
//  AuthorizationPresenter.swift
//  MyAnimVue
//
//  Created by Олег Романов on 29.10.2023.
//

import Foundation

final class AuthorizationPresenter: AuthorizationPresentationLogic {
    
    // MARK: - Instance Properties
    
    private weak var viewController: AuthorizationViewDisplayLogic!
    
    // MARK: - Initializers
    
    init(viewController: AuthorizationViewDisplayLogic) {
        self.viewController = viewController
    }
}
