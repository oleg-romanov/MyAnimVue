//
//  WebViewController.swift
//  MyAnimVue
//
//  Created by Олег Романов on 29.10.2023.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let alertTitleText = "Ошибка"
        static let alertMessageText = "Произошла неизвестная ошибка"
        static let alertActionTitle = "OK"
        static let rightBarButtonTitle = "Закрыть"
    }
    
    // MARK: Instance Properties
    
    var presenter: WebViewPresentationLogic!
    
    private var urlString: String
    
    private var sessionIdIsFound = false
    
    private var observation: NSKeyValueObservation? = nil
    
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.preferences.javaScriptEnabled = true
        webConfiguration.websiteDataStore = WKWebsiteDataStore.default()
        let webView = WKWebView(frame: view.bounds, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    weak var delegate: AuthDelegate?
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    // MARK: Initializers
    
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
        #warning("Временно для отладки чистятся все куки при каждом запуске")
//        HTTPCookieStorage.shared.removeCookies(since: .distantPast)
//        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
//            records.forEach { record in
//                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
//            }
//        }
    }
    
    deinit {
        observation = nil
    }
    
    // MARK: Setup
    
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
            presenter.dismissController()
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
             options: [.new]) { [weak self] _, _ in
                 guard let self = self else { return }
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
    
    // MARK: Constraints
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            progressView.widthAnchor.constraint(equalTo: webView.widthAnchor),
            progressView.topAnchor.constraint(equalTo: webView.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    // MARK: Actions
    
    @objc private func closeButtonDidPress() {
        delegate?.result(isSuccess: false)
        presenter.dismissController()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (change?[NSKeyValueChangeKey.newKey]) != nil {
            webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { [weak self] cookies in
                guard let self = self else {
                    return
                }
                if (urlString.contains("anilib")) {
                    for cookie in cookies {
                        if (cookie.name == "PHPSESSID") {
                            self.sessionIdIsFound = true
                            presenter.saveSessionIdForAnilibria(with: cookie.value)
                        }
                    }
                }
            }
        }
    }
    
    private func checkDocumentOnAuthCode() {
        webView.evaluateJavaScript("document.getElementById('authorization_code').innerText;") { result, error in
            if let result = result {
                self.presenter.saveTokenForShikimori(with: "\(result)")
            }
        }
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate

extension WebViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        if (!sessionIdIsFound) {
            delegate?.result(isSuccess: false)
        }
    }
}

// MARK: - WKNavigationDelegate

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        checkDocumentOnAuthCode()
    }
}

// MARK: - WebViewDisplayLogic

extension WebViewController: WebViewDisplayLogic {
    
    func displaySuccess() {
        delegate?.result(isSuccess: true)
        presenter.dismissController()
    }
    
    func displayErrorAlert(with message: String) {
        let alertController = UIAlertController(
            title: Constants.alertTitleText,
            message: message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(
            title: Constants.alertActionTitle,
            style: .default) { action in
                self.delegate?.result(isSuccess: false)
                self.presenter.dismissController()
        }
        alertController.addAction(action)
        presenter.presentController(controller: alertController)
    }
}
