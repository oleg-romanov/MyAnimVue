//
//  AuthInteractor.swift
//  MyAnimVue
//
//  Created by Олег Романов on 03.07.2024.
//

import Foundation

class AuthInteractor: AuthBusinessLogic {
    
    // MARK: Instance Properties
    
    weak var presenter: AuthPresentationLogic!
    
    private var anilibriaWasCalled: Bool = false
    private var shikimoriWasCalled: Bool = false
    
    private var loggedInToAnilibria: Bool = false
    private var loggedInToShikimori: Bool = false
    
    // MARK: Instance Methods
    
    func setAnilibriaWasCalled() {
        anilibriaWasCalled = true
    }
    
    func setShikimoriWasCalled() {
        shikimoriWasCalled = true
    }
    
    func processResult(isSuccess: Bool) {
        if (isSuccess) {
            if (anilibriaWasCalled) {
                loggedInToAnilibria = true
                presenter.presentCheckmarkAnilibriaCircleView()
            }
            if (shikimoriWasCalled) {
                loggedInToShikimori = true
                presenter.presentCheckmarkShikimoriCircleView()
            }
        }
        anilibriaWasCalled = false
        shikimoriWasCalled = false
        if (loggedInToAnilibria && loggedInToShikimori) {
            presenter.presentStartButtonActiveState()
        }
    }
    
    func startButtonDidPress(isActive: Bool) {
        if isActive {
            presenter.routeToTabbar()
        }
    }
}
