//
//  AuthorizationInteractor.swift
//  MyAnimVue
//
//  Created by Олег Романов on 27.10.2023.
//

import Foundation

final class AuthorizationInteractor: AuthorizationBusinessLogic {
    
    // MARK: - Instance Properties

    private let presenter: AuthorizationPresentationLogic
    
    // MARK: - Initializers
    
    init(presenter: AuthorizationPresentationLogic) {
        self.presenter = presenter
    }
    
    func saveSessionIdForAnilibria(with value: String) {
        
    }
    
    func saveTokensForShikimori() {
        
    }
    
    
}
