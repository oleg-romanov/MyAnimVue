//
//  ProfileProtocols.swift
//  MyAnimVue
//
//  Created by Олег Романов on 05.07.2024.
//

import Foundation

protocol ProfileDisplayLogic: AnyObject {
    func displayTitlesInfo(with models: [[PreviewTitleModel]])
    func displayError(with message: String)
}

protocol ProfilePresentationLogic: AnyObject {
    func fetchTitlesInfo() async
    func presentTitlesInfo(with models: [[PreviewTitleModel]])
    func presentError(with message: String)
}

protocol ProfileBusinessLogic: AnyObject {
    func fetchTitlesInfo() async
}

protocol ProfileRoutingLogic: AnyObject {
    
}

protocol ProfileDelegate: AnyObject {
    
}
