//
//  ProfileHeaderView.swift
//  MyAnimVue
//
//  Created by Олег Романов on 05.07.2024.
//

import UIKit

final class ProfileHeaderView: UIView {
    
    // MARK: Constants
    
    private enum Constants {
        static let backgroundColor: String = "AnimvueBackgroundColor"
        static let logoImageName: String = "AppLogoMini"
        static let titleText: String = "Профиль"
        static let mainTextColor: String = "MainTextColor"
        static let primaryColor: String = "PrimaryColor"
        static let clearColor: String = "ClearColor"
        static let invertedTextColor: String = "InvertedMainTextColor"
        static let lightGrayColorName: String = "LightGrayColor"
        static let leftSegmentControlItemName: String = "Shikimori"
        static let rightSegmentControlItemName: String = "Anilibria"
    }
    
    private struct Appearance: Grid {
        let applicationLogoWidth: CGFloat = 150
        let titleLabelTopAnchor: CGFloat = 59
        let separatorViewHeight: CGFloat = 1
    }
    
    // MARK: Instance Properties
    
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
            NSAttributedString.Key.font: UIFont.boldText!], for: .normal)
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(named: Constants.invertedTextColor)!,
            NSAttributedString.Key.font: UIFont.boldText!], for: .selected)
        segmentedControl.selectedSegmentIndex = SegmentedControlIndex.shikimori.rawValue
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: Constants.lightGrayColorName)
        return view
    }()
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        segmentedControl.frame.size.height = appearance.lSpace
    }
    
    // MARK: Setup
    
    private func setup() {
        backgroundColor = .clear
    }
    
    private func addSubviews() {
        addSubview(applicationLogoView)
        addSubview(titleLabel)
        addSubview(segmentedControl)
        addSubview(separatorView)
    }
    
    // MARK: Constraints
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            applicationLogoView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: appearance.xxlSpace + appearance.xxsSpace
            ),
            applicationLogoView.widthAnchor.constraint(
                equalToConstant: appearance.applicationLogoWidth
            ),
            applicationLogoView.heightAnchor.constraint(
                equalToConstant: appearance.applicationLogoWidth
            ),
            applicationLogoView.centerXAnchor.constraint(
                equalTo: centerXAnchor
            ),
            
            titleLabel.topAnchor.constraint(
                equalTo: applicationLogoView.bottomAnchor,
                constant: appearance.titleLabelTopAnchor
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: appearance.sSpace
            ),
            titleLabel.heightAnchor.constraint(
                equalToConstant: appearance.lSpace + 2
            ),
            
            segmentedControl.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: appearance.sSpace
            ),
            segmentedControl.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: appearance.sSpace
            ),
            segmentedControl.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -appearance.sSpace
            ),
            
            separatorView.topAnchor.constraint(
                equalTo: segmentedControl.bottomAnchor,
                constant: appearance.mSpace
            ),
            separatorView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: appearance.mSpace
            ),
            separatorView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -appearance.mSpace
            ),
            separatorView.heightAnchor.constraint(
                equalToConstant: appearance.separatorViewHeight
            ),
            separatorView.bottomAnchor.constraint(
                equalTo: bottomAnchor
            ),
        ])
    }
}

// MARK: - SegmentedControlIndex

enum SegmentedControlIndex: Int {
    case shikimori = 0
    case anilibria = 1
}
