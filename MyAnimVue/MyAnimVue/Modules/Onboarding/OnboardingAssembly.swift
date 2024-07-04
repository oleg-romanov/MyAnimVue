//
//  OnboardingAssembly.swift
//  MyAnimVue
//
//  Created by Олег Романов on 04.07.2024.
//

import UIKit

final class OnboardingAssembly {
    
    static func setupModule() -> OnboardingViewController {
        let view = OnboardingViewController()
        let presenter = OnboardingPresenter()
        let router = OnboardingRouter()
        
        view.presenter = presenter
        
        presenter.router = router
        
        router.viewController = view
        
        return view
    }
    
    private init() {}
}
