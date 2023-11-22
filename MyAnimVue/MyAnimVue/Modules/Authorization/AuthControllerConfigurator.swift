//
//  AuthorizationControllerConfigurator.swift
//  MyAnimVue
//
//  Created by Олег Романов on 15.10.2023.
//

import UIKit

final class AuthorizationControllerConfigurator {
    
    // MARK:  Instance Methods
    
    func setupModule() -> AuthorizationViewController {
        let viewController = AuthorizationViewController()
        let router = AuthorizationRouter(viewController: viewController)
        viewController.setupComponents(
            router: router
        )
        return viewController
    }
}
