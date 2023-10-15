//
//  AuthorizationControllerConfigurator.swift
//  MyAnimVue
//
//  Created by Олег Романов on 15.10.2023.
//

import UIKit

final class AuthorizationControllerConfigurator {
    
    // MARK:  Instance Methods
    
    func setupModule() -> AuthViewController {
        let viewController = AuthViewController()
        let presenter = AuthPresenter(view: viewController)
        let router = AuthRouter(viewController: viewController)
        viewController.setupComponents(presenter: presenter, router: router)
        return viewController
    }
}
