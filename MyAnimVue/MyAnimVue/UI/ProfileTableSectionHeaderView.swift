//
//  ProfileTableSectionHeaderView.swift
//  MyAnimVue
//
//  Created by Олег Романов on 10.07.2024.
//

import UIKit

final class ProfileTableSectionHeaderView: UIView {
    
    // MARK: Constants
    
    private enum Constants {
        static let accentTextColorName: String = "AccentColor"
        static let mainTextColorName: String = "MainTextColor"
        
        static let seeAllButtonText: String = "См. все "
    }
    
    private struct Appearance: Grid {
        /// = 26
        let blockNameLabelHeight: CGFloat = 26
        /// = 3
        let seeAllButtonBottomInset: CGFloat = -3
    }
    
    // MARK: Instance Properties
    
    private let appearance = Appearance()
    
    private lazy var blockNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Constants.mainTextColorName)
        label.font = UIFont.boldSubtitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.seeAllButtonText, for: .normal)
        button.titleLabel?.font = UIFont.boldMediumText
        button.setTitleColor(UIColor(named: Constants.accentTextColorName), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupStyle()
        addSubviews()
        makeConstraints()
    }
    
    // MARK: Setup
    
    private func setupStyle() {
        backgroundColor = .clear
    }
    
    private func addSubviews() {
        addSubview(blockNameLabel)
        addSubview(seeAllButton)
    }
    
    // MARK: Constraints
    
    private func makeConstraints() {
        seeAllButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        NSLayoutConstraint.activate([
            blockNameLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: appearance.sSpace - 1
            ),
            blockNameLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: appearance.sSpace
            ),
            blockNameLabel.heightAnchor.constraint(
                equalToConstant: appearance.blockNameLabelHeight
            ),
            blockNameLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: seeAllButton.leadingAnchor,
                constant: -appearance.sSpace
            ),
            blockNameLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -appearance.xxsSpace
            ),
            
            seeAllButton.bottomAnchor.constraint(
                equalTo: blockNameLabel.bottomAnchor,
                constant: appearance.seeAllButtonBottomInset
            ),
            seeAllButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -appearance.sSpace
            ),
            seeAllButton.heightAnchor.constraint(
                equalToConstant: appearance.sSpace + 1
            ),
        ])
    }
    
    // MARK: Instance Methods
    
    func configure(blockName: String, titlesCount: Int) {
        blockNameLabel.text = blockName
        seeAllButton.setTitle("\(Constants.seeAllButtonText)(\(titlesCount))", for: .normal)
    }
}
