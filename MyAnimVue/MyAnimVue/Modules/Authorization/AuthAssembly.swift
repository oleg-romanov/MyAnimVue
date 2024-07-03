//
//  AuthAssembly.swift
//  MyAnimVue
//
//  Created by Олег Романов on 15.10.2023.
//

import UIKit

final class AuthAssembly {
    
    static func setupModule() -> AuthViewController {
        let view = AuthViewController()
        let interactor = AuthInteractor()
        let presenter = AuthPresenter()
        let router = AuthRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = view
        
        return view
    }
    
    private init() {}
}
