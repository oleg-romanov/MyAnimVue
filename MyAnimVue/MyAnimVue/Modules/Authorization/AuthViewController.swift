//
//  AuthViewController.swift
//  MyAnimVue
//
//  Created by Олег Романов on 13.10.2023.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {
    
    // MARK:  Properties
    
    private let webView: WKWebView = {
        let webview = WKWebView()
        webview.translatesAutoresizingMaskIntoConstraints = false
        return webview
    }()
    
    private var presenter: AuthViewPresenter!
    private var router: AuthRoutingLogic!
    
    // MARK: - Setup

    func setupComponents(
        presenter: AuthViewPresenter,
        router: AuthRoutingLogic
    ) {
        self.presenter = presenter
        self.router = router
    }
    
    // MARK:  ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeConstraints()
        
        webView.load(URLRequest(url: URL(string: "https://zerkalo.anilib.top/pages/login.php")!))
        webView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let key = change?[NSKeyValueChangeKey.newKey] {
            print("observeValue \(key)") // url value
            webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
                var sessionIdIsFound = false
                for cookie in cookies {
                    if (cookie.name == "PHPSESSID") {
                        sessionIdIsFound = true
                        self.presenter.saveSessionId(with: cookie.value)
                    }
                }
                // TODO: Заменить ошибки
                if (sessionIdIsFound) {
                    self.router.routeToTabbar()
                } else {
                    self.displayErrorAlert(with: "Произошла ошибка авторизации, попробуйте снова")
                }
            }
        }
    }
    
    // MARK:  Setup style
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func addSubviews() {
        view.addSubview(webView)
    }
}

extension AuthViewController: AuthView {
    func displayErrorAlert(with message: String) {
        let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(errorAlert, animated: true)
    }
}
