//
//  WebViewPresenter.swift
//  MyAnimVue
//
//  Created by Олег Романов on 01.11.2023.
//

import Foundation

final class WebViewPresenter: WebViewPresentationLogic {
    
    // MARK: - Instance Properties
    
    private weak var viewController: WebViewDisplayLogic!
    
    // MARK: - Initializers
    
    init(viewController: WebViewDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentSuccess() {
        viewController.displaySuccess()
    }
    
    func presentError() {
        viewController.displayErrorAlert()
    }
}
