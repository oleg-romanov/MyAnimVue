//
//  WebViewRouter.swift
//  MyAnimVue
//
//  Created by Олег Романов on 21.11.2023.
//

import UIKit

final class WebViewRouter: WebViewRoutingLogic {
    
    // MARK: Instance Properties

    weak var viewController: UIViewController!
    
    // MARK: Instance Methods
    
    func dismissController() {
        viewController.dismiss(animated: true)
    }
    
    func presentController(controller: NSObject) {
        guard let controller = controller as? UIViewController else { return }
        viewController.present(controller, animated: true)
    }
}
