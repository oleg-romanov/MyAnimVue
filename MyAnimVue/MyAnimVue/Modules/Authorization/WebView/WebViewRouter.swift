//
//  WebViewRouter.swift
//  MyAnimVue
//
//  Created by Олег Романов on 21.11.2023.
//

import UIKit

final class WebViewRouter: WebViewRoutingLogic {
    
    // MARK: - Instance Properties

    private weak var viewController: UIViewController!

    // MARK: - Initializers

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func dismissController(with completion: @escaping () -> Void) {
        viewController.dismiss(animated: true) {
            completion()
        }
    }
    
    func dismissController() {
        viewController.dismiss(animated: true)
    }
    
    func presentController(viewController: UIViewController) {
        viewController.present(viewController, animated: true)
    }
}
