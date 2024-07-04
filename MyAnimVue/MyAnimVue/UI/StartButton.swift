//
//  StartButton.swift
//  MyAnimVue
//
//  Created by Олег Романов on 28.10.2023.
//

import UIKit

final class StartButton: UIButton {
    
    // MARK: Constants
    
    private enum Constants {
        static let textColor = "InvertedMainTextColor"
        static let inactiveBackgroundColor = "StartButtonColor"
        static let activeBackgroundColor = "AccentColor"
        static let cornerRadius: CGFloat = 14
    }
    
    // MARK: Instance Properties
    
    private(set) var isActive: Bool = false {
        didSet {
            if (isActive) {
                UIView.animate(withDuration: 1, delay: 0.7, options: .curveEaseOut) {
                    self.backgroundColor = UIColor(named: Constants.activeBackgroundColor)
                }
            }
        }
    }
    
    // MARK: Initializers
    
    init(title: String) {
        super.init(frame: .zero)
        setupStyle(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setupStyle(title: String) {
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.semiboldTitle
        setTitleColor(UIColor(named: Constants.textColor), for: .normal)
        backgroundColor = UIColor(named: Constants.inactiveBackgroundColor)
        layer.cornerRadius = Constants.cornerRadius
    }
    
    // MARK: Instance Methods
    
    func setActive() {
        isActive = true
    }
}
