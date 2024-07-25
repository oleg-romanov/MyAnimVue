//
//  FavoriteTitlesCell.swift
//  MyAnimVue
//
//  Created by Олег Романов on 24.07.2024.
//

import UIKit

final class FavoriteTitlesCell: UITableViewCell {
    
    // MARK: Constants
    
    private struct Constants {
        static let lightGrayColorName: String = "LightGrayColor"
        static let favoritesIconName: String = "favoritesIcon"
        static let disclosureIconName: String = "disclosureIcon"
        static let titleLableText: String = "Избранное"
        static let mainTextColorName: String = "MainTextColor"
    }
    
    // MARK: Appearance
    
    private struct Appearance: Grid {
        /// = 2
        let separatorViewHeight: CGFloat = 1
        /// = 20
        let titleLabelLineHeight: CGFloat = 20
    }

    // MARK: Instance Properties
    
    private let appearance = Appearance()
    
    private lazy var favoritesIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.favoritesIconName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldMediumText
        label.textColor = UIColor(named: Constants.mainTextColorName)
        label.setAttributedText(Constants.titleLableText, lineHeight: appearance.titleLabelLineHeight)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var disclosureIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.disclosureIconName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: Constants.lightGrayColorName)
        return view
    }()
    
    // MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        contentView.addSubview(favoritesIconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(disclosureIconImageView)
        contentView.addSubview(separatorView)
    }
    
    // MARK: Constraints
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            favoritesIconImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: appearance.xxsSpace
            ),
            favoritesIconImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: appearance.sSpace
            ),
            
            titleLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: appearance.sSpace - 4
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: favoritesIconImageView.trailingAnchor,
                constant: appearance.sSpace
            ),
            titleLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: separatorView.trailingAnchor
            ),
            
            disclosureIconImageView.centerYAnchor.constraint(
                equalTo: titleLabel.centerYAnchor
            ),
            disclosureIconImageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -appearance.sSpace
            ),
            
            separatorView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: appearance.sSpace - 5
            ),
            separatorView.heightAnchor.constraint(
                equalToConstant: appearance.separatorViewHeight
            ),
            separatorView.leadingAnchor.constraint(
                equalTo: titleLabel.leadingAnchor
            ),
            separatorView.trailingAnchor.constraint(
                equalTo: disclosureIconImageView.leadingAnchor,
                constant: -appearance.xxsSpace
            ),
            separatorView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
        ])
    }
}
