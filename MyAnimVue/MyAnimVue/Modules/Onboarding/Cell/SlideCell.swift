//
//  SlideCell.swift
//  MyAnimVue
//
//  Created by Олег Романов on 04.07.2024.
//

import UIKit

final class SlideCell: UICollectionViewCell {
    
    // MARK: Constants
    
    private enum Constants {
        static let titleTextColorFirstAndLastPg = "MainTextColor"
        static let titleTextColor = "AccentColor"
        static let descriptionLabelTextColor = "MainTextColor"
    }
    
    // MARK: Appearance
    
    private struct Appearance: Grid {
        let titleLabelTopAnchor: CGFloat = 72
        let titleLabelTopAnchorFirstPg: CGFloat = 92
        let descriptionLabelTopAnchor: CGFloat = 32
    }
    
    // MARK: Instance Properties
    
    private var appearance = Appearance()
    
    private var titleTopConstraint: NSLayoutConstraint!
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldTitle
        label.textColor = UIColor(named: Constants.titleTextColor)
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularText
        label.textColor = UIColor(named: Constants.descriptionLabelTextColor)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = .zero
        return label
    }()
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setupStyle() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    // MARK: Constraints
    
    private func makeConstraints() {
        titleTopConstraint = titleLabel.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: appearance.titleLabelTopAnchor
        )
        NSLayoutConstraint.activate([
            titleTopConstraint,
            titleLabel.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
            titleLabel.leadingAnchor.constraint(
                greaterThanOrEqualTo: contentView.leadingAnchor,
                constant: appearance.mSpace + 4
            ),
            titleLabel.trailingAnchor.constraint(
                greaterThanOrEqualTo: contentView.trailingAnchor,
                constant: -(appearance.mSpace + 4)
            ),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: appearance.lSpace
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: appearance.mSpace + 4
            ),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -(appearance.mSpace + 4)
            ),
            descriptionLabel.bottomAnchor.constraint(
                lessThanOrEqualTo: contentView.bottomAnchor,
                constant: -appearance.sSpace
            )
        ])
    }
    
    // MARK: Instance Methods
    
    func configure(slide: Slide) {
        titleLabel.text = slide.title
        descriptionLabel.text = slide.description
        
        if slide.isFirstSlide {
            titleLabel.textColor = UIColor(named: Constants.titleTextColorFirstAndLastPg)
            titleTopConstraint.constant = appearance.titleLabelTopAnchorFirstPg
        } else {
            titleTopConstraint.constant = appearance.titleLabelTopAnchor
        }
        
        if slide.isLastSlide {
            titleLabel.textColor = UIColor(named: Constants.titleTextColorFirstAndLastPg)
        }
        
        layoutIfNeeded()
    }
}
