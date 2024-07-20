//
//  ProfileProtocols.swift
//  MyAnimVue
//
//  Created by Олег Романов on 05.07.2024.
//

import Foundation

protocol ProfileDisplayLogic: AnyObject {
    func displayTitlesInfo(with models: [[PreviewTitleModel]])
}

protocol ProfilePresentationLogic: AnyObject {
    func fetchTitlesInfo()
    func presentTitlesInfo(with models: [[PreviewTitleModel]])
}

protocol ProfileBusinessLogic: AnyObject {
    func fetchTitlesInfo()
}

protocol ProfileRoutingLogic: AnyObject {
    
}

protocol ProfileDelegate: AnyObject {
    
}
