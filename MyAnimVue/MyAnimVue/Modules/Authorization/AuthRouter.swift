//
//  AuthorizationRouter.swift
//  MyAnimVue
//
//  Created by Олег Романов on 29.10.2023.
//

import UIKit

final class AuthRouter: AuthRoutingLogic {
    
    // MARK: Instance Properties

    weak var viewController: UIViewController!
    
    // MARK: Instance Methods
    
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
    
    func routeToWebView(by urlString: String, from: NSObject) {
        guard let from = from as? AuthViewController else { return }
        let webViewController = WebViewAssembly.setupModule(with: urlString)
        webViewController.delegate = from
        let navController = UINavigationController(rootViewController: webViewController)
        viewController.present(navController, animated: true, completion: nil)
    }
}
