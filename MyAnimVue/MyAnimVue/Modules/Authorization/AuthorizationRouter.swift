//
//  AuthorizationRouter.swift
//  MyAnimVue
//
//  Created by Олег Романов on 29.10.2023.
//

import UIKit

final class AuthorizationRouter: AuthorizationRoutingLogic {
    
    // MARK: - Instance Properties

    private weak var viewController: UIViewController!

    // MARK: - Initializers

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func routeToTabbar() {
        // TODO: Заменить стандартный Tabbar
        let tabbar = UITabBarController()
        guard let window = viewController.window else {
            return
        }
        UIWindow.transition(with: window, duration: 0.3, options: .transitionCrossDissolve) {
            window.rootViewController = tabbar
        }
    }
    
    func routeToWebView(by urlString: String, from: AuthorizationViewController) {
        let webViewController = WebViewControllerConfigurator().setupModule(with: urlString)
        webViewController.delegate = from
        let navController = UINavigationController(rootViewController: webViewController)
        viewController.present(navController, animated: true, completion: nil)
    }
}
