//
//  UIWindow+Extensions.swift
//  MyAnimVue
//
//  Created by Олег Романов on 04.07.2024.
//

import UIKit

extension UIWindow {
    func setRootViewController(_ viewController: UIViewController, animated: Bool = true) {
        guard animated else {
            rootViewController = viewController
            makeKeyAndVisible()
            return
        }
        
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        })
    }
}
