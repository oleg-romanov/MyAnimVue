//
//  WebViewAssembly.swift
//  MyAnimVue
//
//  Created by Олег Романов on 21.11.2023.
//

import UIKit

final class WebViewAssembly {
    
    static func setupModule(with urlString: String) -> WebViewController {
        let view = WebViewController(with: urlString)
        let interactor = WebViewInteractor()
        let presenter = WebViewPresenter()
        let router = WebViewRouter()
        
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
