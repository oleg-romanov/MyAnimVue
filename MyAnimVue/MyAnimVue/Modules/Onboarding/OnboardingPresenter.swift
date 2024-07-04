//
//  OnboardingPresenter.swift
//  MyAnimVue
//
//  Created by Олег Романов on 04.07.2024.
//

import Foundation

final class OnboardingPresenter: OnboardingPresentationLogic {
    
    // MARK: Instance Properties
    
    var router: OnboardingRoutingLogic!
    
    // MARK: Instance Methods
    
    func nextButtonInFinalStateDidPress() {
        router.routeToAuthScreen()
    }
}
