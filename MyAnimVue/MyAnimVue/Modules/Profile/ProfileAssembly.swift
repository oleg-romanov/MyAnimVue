//
//  ProfileAssembly.swift
//  MyAnimVue
//
//  Created by Олег Романов on 05.07.2024.
//

import UIKit

final class ProfileAssembly {
    
    static func setupModule() -> ProfileViewController {
        let view = ProfileViewController()
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
        
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
