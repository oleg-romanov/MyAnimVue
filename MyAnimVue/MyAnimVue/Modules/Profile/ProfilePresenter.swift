//
//  ProfilePresenter.swift
//  MyAnimVue
//
//  Created by Олег Романов on 05.07.2024.
//

import Foundation

final class ProfilePresenter: ProfilePresentationLogic {
        
    // MARK: Instance Properties
    
    var interactor: ProfileBusinessLogic!
    var router: ProfileRoutingLogic!
    weak var view: ProfileDisplayLogic!
    
    // MARK: Instance Methods
    
    func fetchTitlesInfo() {
        interactor.fetchTitlesInfo()
    }
    
    func presentTitlesInfo(with models: [[PreviewTitleModel]]) {
        view.displayTitlesInfo(with: models)
    }
}
