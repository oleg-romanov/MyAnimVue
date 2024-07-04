//
//  OnboardingRouter.swift
//  MyAnimVue
//
//  Created by Олег Романов on 04.07.2024.
//

import UIKit

final class OnboardingRouter: OnboardingRoutingLogic {
    
    // MARK: Instance Propertie
    
    weak var viewController: UIViewController!
    
    func routeToAuthScreen() {
        let authController = AuthAssembly.setupModule()
        viewController.window?.setRootViewController(authController, animated: true)
    }
}
