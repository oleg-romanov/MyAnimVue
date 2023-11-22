//
//  AuthViewController.swift
//  MyAnimVue
//
//  Created by Олег Романов on 13.10.2023.
//

import UIKit
import WebKit

protocol AuthDelegate: AnyObject {
    func result(isSuccess: Bool)
}

class AuthorizationViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let logoImageName = "AppLogoMini"
        static let mainTextColor = "MainTextColor"
        static let signInButtonColor = "AccentColor"
        static let descriptionTextColor = "SecondaryTextColor"
        static let signInButtonText = "Войти"
        static let viewBackgroundColor = "AnimvueBackgroundColor"
        static let checkmarkStateOffName = "checkmarkCircleOff"
        static let checkmarkStateOnName = "checkmarkCircleOn"
        static let titleText = "АВТОРИЗАЦИЯ"
        static let descriptionText = "Чтобы начать пользоваться MyAnimVue необходимо войти или создать аккаунт на Anilibria и Shikimori."
        static let anilibriaLabelText = "Anilibria"
        static let shikimoriLabelText = "Shikimori"
        static let startButtonTitle = "Начать"
        static let anilibriaUrl = "https://zerkalo.anilib.top/pages/login.php"
        static let shikimoriUrl = "https://shikimori.one/oauth/authorize?client_id=Wfh14ofSdXt5bqTMgdXEaJQpuNZVUxiL86M0VUSF-5E&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&scope=user_rates+comments+topics"
    }
    
    // MARK: - Appearance

    private struct Appearance: Grid {
        let applicationLogoWidth: CGFloat = 150
        let applicationLogoTopAnchor: CGFloat = 90
        let titleLableTopAnchor: CGFloat = 60
        let startButtonHeight: CGFloat = 60
    }
    
    // MARK: - Instance Properties
    
    private var router: AuthorizationRoutingLogic!
    
    private let appearance = Appearance()
    
    private var anilibriaWasCalled: Bool = false
    private var shikimoriWasCalled: Bool = false
    
    private var loggedInToAnilibria: Bool = false
    private var loggedInToShikimori: Bool = false
    
    private lazy var applicationLogoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.logoImageName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldTitle
        label.textColor = UIColor(named: Constants.mainTextColor)
        label.text = Constants.titleText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumText
        label.textColor = UIColor(named: Constants.descriptionTextColor)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = .zero
        label.text = Constants.descriptionText
        
        return label
    }()
    
    private lazy var checkmarkAnilibriaCircleView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.checkmarkStateOffName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var anilibriaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldText
        label.textColor = UIColor(named: Constants.mainTextColor)
        label.text = Constants.anilibriaLabelText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var checkmarkShikimoriCircleView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.checkmarkStateOffName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var shikimoriLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldText
        label.textColor = UIColor(named: Constants.mainTextColor)
        label.text = Constants.shikimoriLabelText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var signInToAnilibriaButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.signInButtonText, for: .normal)
        
        button.setTitleColor(UIColor(named: Constants.signInButtonColor), for: .normal)
        button.titleLabel?.font = UIFont.boldText
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(anilibriaLoginButtonDidPress), for: .touchUpInside)
        return button
    }()
    
    private lazy var signInToShikimoriButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.signInButtonText, for: .normal)
        
        button.setTitleColor(UIColor(named: Constants.signInButtonColor), for: .normal)
        button.titleLabel?.font = UIFont.boldText
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(shikimoriLoginButtonDidPress), for: .touchUpInside)
        return button
    }()
    
    private lazy var startButton: StartButton = {
        let button = StartButton(title: Constants.startButtonTitle)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonDidPress), for: .touchUpInside)
        return button
    }()
    
    // MARK:  Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        makeConstraints()
    }
    
    // MARK: - Setup

    func setupComponents(
        router: AuthorizationRoutingLogic
    ) {
        self.router = router
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: Constants.viewBackgroundColor)
    }
    
    private func addSubviews() {
        view.addSubview(applicationLogoView)
        view.addSubview(titleLable)
        view.addSubview(descriptionLabel)
        view.addSubview(anilibriaLabel)
        view.addSubview(shikimoriLabel)
        view.addSubview(signInToAnilibriaButton)
        view.addSubview(signInToShikimoriButton)
        view.addSubview(checkmarkAnilibriaCircleView)
        view.addSubview(checkmarkShikimoriCircleView)
        view.addSubview(startButton)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            applicationLogoView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: appearance.xxlSpace - 2),
            applicationLogoView.widthAnchor.constraint(equalToConstant: appearance.applicationLogoWidth),
            applicationLogoView.heightAnchor.constraint(equalTo: applicationLogoView.widthAnchor),
            applicationLogoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            titleLable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: appearance.sSpace),
            titleLable.topAnchor.constraint(equalTo: applicationLogoView.bottomAnchor, constant: appearance.titleLableTopAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: appearance.sSpace),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -appearance.sSpace),
            descriptionLabel.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: appearance.lSpace),
            
            checkmarkAnilibriaCircleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: appearance.sSpace),
            checkmarkAnilibriaCircleView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: appearance.lSpace),
            checkmarkAnilibriaCircleView.widthAnchor.constraint(equalToConstant: appearance.sSpace),
            checkmarkAnilibriaCircleView.heightAnchor.constraint(equalTo: checkmarkAnilibriaCircleView.widthAnchor),
            
            anilibriaLabel.leadingAnchor.constraint(equalTo: checkmarkAnilibriaCircleView.trailingAnchor, constant: appearance.xxsSpace),
            anilibriaLabel.topAnchor.constraint(equalTo: checkmarkAnilibriaCircleView.topAnchor),
            anilibriaLabel.heightAnchor.constraint(equalToConstant: appearance.sSpace),
            
            signInToAnilibriaButton.leadingAnchor.constraint(equalTo: anilibriaLabel.trailingAnchor, constant: appearance.mSpace),
            signInToAnilibriaButton.topAnchor.constraint(equalTo: anilibriaLabel.topAnchor),
            signInToAnilibriaButton.heightAnchor.constraint(equalToConstant: appearance.sSpace),
            
            checkmarkShikimoriCircleView.leadingAnchor.constraint(equalTo: checkmarkAnilibriaCircleView.leadingAnchor),
            checkmarkShikimoriCircleView.topAnchor.constraint(equalTo: checkmarkAnilibriaCircleView.bottomAnchor, constant: appearance.mSpace + 4),
            
            shikimoriLabel.leadingAnchor.constraint(equalTo: checkmarkShikimoriCircleView.trailingAnchor, constant: appearance.xxsSpace),
            shikimoriLabel.topAnchor.constraint(equalTo: checkmarkShikimoriCircleView.topAnchor),
            shikimoriLabel.heightAnchor.constraint(equalToConstant: appearance.sSpace),
            
            signInToShikimoriButton.leadingAnchor.constraint(equalTo: signInToAnilibriaButton.leadingAnchor),
            signInToShikimoriButton.topAnchor.constraint(equalTo: shikimoriLabel.topAnchor),
            signInToShikimoriButton.heightAnchor.constraint(equalToConstant: appearance.sSpace),

            startButton.heightAnchor.constraint(equalToConstant: appearance.startButtonHeight),
            startButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: appearance.mSpace + 4),
            startButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -appearance.mSpace + 4),
            startButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -appearance.xxsSpace)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func anilibriaLoginButtonDidPress() {
        showLoading()
        anilibriaWasCalled = true
        router.routeToWebView(by: Constants.anilibriaUrl, from: self)
    }
    
    @objc private func shikimoriLoginButtonDidPress() {
        showLoading()
        shikimoriWasCalled = true
        router.routeToWebView(by: Constants.shikimoriUrl, from: self)
    }
    
    @objc private func startButtonDidPress() {
        if (startButton.isActive) {
            router.routeToTabbar()
        }
    }
}

extension AuthorizationViewController: AuthorizationViewDisplayLogic, AuthDelegate {
    func result(isSuccess: Bool) {
        hideLoading()
        if (isSuccess) {
            if (anilibriaWasCalled) {
                loggedInToAnilibria = true
                checkmarkAnilibriaCircleView.image = UIImage(named: Constants.checkmarkStateOnName)
            }
            if (shikimoriWasCalled) {
                loggedInToShikimori = true
                checkmarkShikimoriCircleView.image = UIImage(named: Constants.checkmarkStateOnName)
            }
        }
        anilibriaWasCalled = false
        shikimoriWasCalled = false
        if (loggedInToAnilibria && loggedInToShikimori) {
            startButton.setActive()
        }
    }
    
    func displaySuccess() {
        // TODO: Display logic
    }
    
    func displayErrorAlert(with message: String) {
        let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(errorAlert, animated: true)
    }
}
