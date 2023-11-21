//
//  WebViewControllerConfigurator.swift
//  MyAnimVue
//
//  Created by Олег Романов on 21.11.2023.
//

import UIKit

final class WebViewControllerConfigurator {
    
    // MARK:  Instance Methods
    
    func setupModule(with urlString: String) -> WebViewController {
        let viewController = WebViewController(with: urlString)
        let presenter = WebViewPresenter(viewController: viewController)
        let interactor = WebViewInteractor(presenter: presenter)
        let router = WebViewRouter(viewController: viewController)
        viewController.setupComponents(
            interactor: interactor,
            router: router
        )
        return viewController
    }
}
