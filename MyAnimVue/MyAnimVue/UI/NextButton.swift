//
//  NextButton.swift
//  MyAnimVue
//
//  Created by Олег Романов on 04.07.2024.
//

import UIKit

final class NextButton: UIButton {
    
    // MARK: Constants
    
    private enum Constants {
        static let textColor = "InvertedMainTextColor"
        static let backgroundColor = "PrimaryColor"
        static let cornerRadius: CGFloat = 14
        static let finalStateTitleText: String = "Приступим!"
    }
    
    // MARK: Instance Properties
    
    private var title: String = ""

    // MARK: Initializers
    
    init(title: String) {
        super.init(frame: .zero)
        self.title = title
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setupStyle() {
        setOriginalTitle()
        titleLabel?.font = UIFont.semiboldTitle
        setTitleColor(UIColor(named: Constants.textColor), for: .normal)
        backgroundColor = UIColor(named: Constants.backgroundColor)
        layer.cornerRadius = Constants.cornerRadius
    }
    
    // MARK: Instance Methods
    
    func setFinalState(_ title: String? = nil) {
        setTitle(title ?? Constants.finalStateTitleText, for: .normal)
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform.identity
            }
        }
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    func setOriginalTitle() {
        setTitle(title, for: .normal)
    }
}
