//
//  WebViewController.swift
//  MyAnimVue
//
//  Created by Олег Романов on 29.10.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let alertTitleText = "Ошибка"
        static let alertMessageText = "Произошла неизвестная ошибка"
        static let alertActionTitle = "OK"
        static let rightBarButtonTitle = "Закрыть"
    }
    
    // MARK: - Instance Properties
    
    private var interactor: WebViewBusinessLogic!
    private var router: WebViewRoutingLogic!
    
    private var urlString: String
    
    private var sessionIdIsFound = false
    
    private var observation: NSKeyValueObservation? = nil
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    weak var delegate: AuthDelegate?
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    // MARK:  Initializers
    
    init(with urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.presentationController?.delegate = self
        webView.navigationDelegate = self
        addSubviews()
        makeConstraints()
        setup()
    }
    
    deinit {
        observation = nil
    }
    
    // MARK: Setup
    
    func setupComponents(
        interactor: WebViewBusinessLogic,
        router: WebViewRoutingLogic
    ) {
        self.interactor = interactor
        self.router = router
    }
    
    private func setup() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: Constants.rightBarButtonTitle,
            style: .plain,
            target: self,
            action: #selector(closeButtonDidPress)
        )
        
        self.navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        
        guard let url = URL(string: urlString) else {
            // TODO: Обработать ошибку
            delegate?.result(isSuccess: false)
            router.dismissController()
            return
        }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        webView.addObserver(
            self,
            forKeyPath: "URL",
            options: .new,
            context: nil
        )
        observation = webView.observe(
            \.estimatedProgress,
             options: [.new]) { _, _ in
                 self.progressView.progress = Float(self.webView.estimatedProgress)
                 if (self.webView.estimatedProgress == 1.0) {
                    self.progressView.isHidden = true
                 }
        }
        checkDocumentOnAuthCode()
    }
    
    private func addSubviews() {
        view.addSubview(webView)
        view.addSubview(progressView)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: super.view.leadingAnchor),
            webView.topAnchor.constraint(equalTo: super.view.topAnchor),
            webView.trailingAnchor.constraint(equalTo: super.view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: super.view.bottomAnchor),
            
            progressView.widthAnchor.constraint(equalTo: webView.widthAnchor),
            progressView.topAnchor.constraint(equalTo: webView.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    // MARK:  Actions
    
    @objc private func closeButtonDidPress() {
        router.dismissController {
            self.delegate?.result(isSuccess: false)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let key = change?[NSKeyValueChangeKey.newKey] {
            webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { [weak self] cookies in
                guard let self = self else {
                    return
                }
                if (urlString.contains("anilib")) {
                    for cookie in cookies {
                        if (cookie.name == "PHPSESSID") {
                            self.sessionIdIsFound = true
                            interactor.saveSessionIdForAnilibria(with: cookie.value)
                        }
                    }
                }
            }
        }
    }
    
    private func checkDocumentOnAuthCode() {
        webView.evaluateJavaScript("document.getElementById('authorization_code').innerText;") { result, error in
            if let result = result {
                self.interactor.saveTokensForShikimori(with: "\(result)")
            }
        }
    }
}

// MARK:  UIAdaptivePresentationControllerDelegate

extension WebViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        if (!sessionIdIsFound) {
            self.delegate?.result(isSuccess: false)
        }
    }
}

// MARK:  WKNavigationDelegate

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        checkDocumentOnAuthCode()
    }
}

// MARK:  WebViewDisplayLogic

extension WebViewController: WebViewDisplayLogic {
    
    func displaySuccess() {
        delegate?.result(isSuccess: true)
        router.dismissController()
    }
    
    func displayErrorAlert() {
        let alertController = UIAlertController(
            title: Constants.alertTitleText,
            message: Constants.alertMessageText,
            preferredStyle: .alert
        )
        let action = UIAlertAction(
            title: Constants.alertActionTitle,
            style: .default) { action in
                self.router.dismissController {
                    self.delegate?.result(isSuccess: false)
                }
        }
        alertController.addAction(action)
        router.presentController(viewController: alertController)
    }
}
