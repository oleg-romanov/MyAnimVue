//
//  ProfileViewController.swift
//  MyAnimVue
//
//  Created by Олег Романов on 05.07.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let backgroundColor: String = "AnimvueBackgroundColor"
        static let logoImageName: String = "AppLogoMini"
        static let titleText = "Профиль"
        static let mainTextColor = "MainTextColor"
        static let primaryColor = "PrimaryColor"
        static let accentTextColor = "AccentColor"
        static let clearColor = "ClearColor"
        static let invertedTextColor = "InvertedMainTextColor"
        static let leftSegmentControlItemName = "Shikimori"
        static let rightSegmentControlItemName = "Anilibria"
    }
    
    private struct Appearance: Grid {
        let applicationLogoWidth: CGFloat = 150
        let applicationLogoTopAnchor: CGFloat = 90
        let titleLabelTopAnchor: CGFloat = 60
    }
    
    private enum SegmentedControlIndex: Int {
        case shikimori = 0
        case anilibria = 1
    }
    
    // MARK: Instance Properties
    
    var presenter: ProfilePresentationLogic!
    
    private let appearance = Appearance()
    
    private lazy var applicationLogoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.logoImageName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titleText
        label.font = UIFont.boldTitle
        label.tintColor = UIColor(named: Constants.mainTextColor)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [Constants.leftSegmentControlItemName, Constants.rightSegmentControlItemName]
        )
        segmentedControl.backgroundColor = UIColor(named: Constants.clearColor)
        segmentedControl.selectedSegmentTintColor = UIColor(named: Constants.primaryColor)
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(named: Constants.mainTextColor)!,
            NSAttributedString.Key.font: UIFont.boldMediumText!], for: .normal)
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(named: Constants.invertedTextColor)!,
            NSAttributedString.Key.font: UIFont.boldMediumText!], for: .selected)
        segmentedControl.selectedSegmentIndex = SegmentedControlIndex.shikimori.rawValue
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addSubviews()
        makeConstraints()
    }
    
    // MARK: Setup
    
    private func setup() {
        view.backgroundColor = UIColor(named: Constants.backgroundColor)
    }
    
    private func addSubviews() {
        view.addSubview(applicationLogoView)
        view.addSubview(titleLabel)
        view.addSubview(segmentedControl)
    }
    
    // MARK: Constraints
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            applicationLogoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: appearance.xxlSpace - 2),
            applicationLogoView.widthAnchor.constraint(equalToConstant: appearance.applicationLogoWidth),
            applicationLogoView.heightAnchor.constraint(equalTo: applicationLogoView.widthAnchor),
            applicationLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleLabel.topAnchor.constraint(
                equalTo: applicationLogoView.bottomAnchor,
                constant: appearance.titleLabelTopAnchor
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: appearance.sSpace
            ),
            
            segmentedControl.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: appearance.mSpace + 4
            ),
            segmentedControl.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: appearance.sSpace
            ),
            segmentedControl.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -appearance.sSpace
            ),
            segmentedControl.heightAnchor.constraint(
                equalToConstant: appearance.lSpace
            ),
        ])
    }
}

extension ProfileViewController: ProfileDisplayLogic {
}
