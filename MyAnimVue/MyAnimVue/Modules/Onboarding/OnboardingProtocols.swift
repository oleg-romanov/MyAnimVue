//
//  OnboardingProtocols.swift
//  MyAnimVue
//
//  Created by Олег Романов on 04.07.2024.
//

import Foundation

protocol OnboardingPresentationLogic: AnyObject {
    func nextButtonInFinalStateDidPress()
}

protocol OnboardingRoutingLogic: AnyObject {
    func routeToAuthScreen()
}
