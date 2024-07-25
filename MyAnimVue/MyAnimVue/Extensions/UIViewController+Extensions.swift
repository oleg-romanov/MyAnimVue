//
//  UIViewController+Extensions.swift
//  MyAnimVue
//
//  Created by Олег Романов on 15.10.2023.
//

import UIKit

extension UIViewController {
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var sceneDelegate: SceneDelegate? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate else { return nil }
        return delegate
    }
    
    func showLoading() {
        guard let window = window else {
            assertionFailure("Can't get window")
            return
        }
        let loadingView = LoadingView(frame: UIScreen.main.bounds)
        window.addSubview(loadingView)
        window.bringSubviewToFront(loadingView)
    }
    
    func hideLoading() {
        guard let window = window else {
            assertionFailure("Can't get window")
            return
        }
        window.subviews
            .filter { $0 is LoadingView }
            .forEach { $0.removeFromSuperview() }
    }
    
    private func getKeyWindow() -> UIWindow? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return nil
        }
        return window
    }
}

extension UIViewController {
    var window: UIWindow? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate,
              let window = delegate.window else { return nil }
        return window
    }
}

extension UIViewController {
    func showErrorAlert(message: String) {
        guard let window = getKeyWindow() else {
            assertionFailure("Can't get keyWindow")
            return
        }
        
        let errorView = BottomErrorView(text: message)
        errorView.translatesAutoresizingMaskIntoConstraints = false 
        window.addSubview(errorView)
        window.bringSubviewToFront(errorView)
        
        NSLayoutConstraint.activate([
            errorView.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor, constant: -16.0),
            errorView.leadingAnchor.constraint(equalTo: window.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            errorView.trailingAnchor.constraint(equalTo: window.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            errorView.heightAnchor.constraint(equalToConstant: 80.0)
        ])
        
        errorView.show()
    }
}

