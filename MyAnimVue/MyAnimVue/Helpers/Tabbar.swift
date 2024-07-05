//
//  Tabbar.swift
//  MyAnimVue
//
//  Created by Олег Романов on 05.07.2024.
//

import UIKit

final class Tabbar: UITabBarController {
    
    // MARK: Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setup() {
        let profileVC = ProfileAssembly.setupModule()
        let profileNav = UINavigationController(rootViewController: profileVC)
        
        profileNav.tabBarItem.image = UIImage(named: "UnselectedProfileIcon")
        profileNav.tabBarItem.title = "Профиль"
        
        viewControllers = [profileNav]
    }
}
