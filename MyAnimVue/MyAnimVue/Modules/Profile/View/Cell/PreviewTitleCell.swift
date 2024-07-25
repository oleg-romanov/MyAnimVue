//
//  PreviewTitleCell.swift
//  MyAnimVue
//
//  Created by Олег Романов on 07.07.2024.
//

import UIKit

final class PreviewTitleCell: UICollectionViewCell {
    
    // MARK: Constants
    
    private enum Constants {
        static let posterImageViewCornerRadiud: CGFloat = 14
        
        static let mainTextColorName: String = "MainTextColor"
        static let grayTextColorName: String = "GrayTextColor"
        static let primaryColorName: String = "PrimaryColor"
        static let lightGrayColorName: String = "LightGrayColor"
        
        static let imagesHostUrlString: String = "https://desu.shikimori.one"
        
        static let epicodesLabelText: String = "Эпизоды: "
        /// = 2
        static let titleRussianNameLabelNumberOfLines: Int = 2
        /// = 1
        static let subtitleEnglishNameLabelNumberOfLines: Int = 1
        
        static let titleLineHeight: CGFloat = 20
        static let subtitleLineHeight: CGFloat = 20
        static let episodesLineHeight: CGFloat = 18
    }
    
    private struct Appearance: Grid {
        /// = 1
        let separatorViewHeight: CGFloat = 1
        /// = 82
        let posterImageViewHeight: CGFloat = 82
    }
    
    // MARK: Instance Properties
    
    private let appearance: Appearance = Appearance()
    
    private lazy var posterImageView: AsyncImageView = {
        let imageView = AsyncImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.posterImageViewCornerRadiud
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleRussianNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = Constants.titleRussianNameLabelNumberOfLines
        label.font = UIFont.boldMediumText
        label.textColor = UIColor(named: Constants.mainTextColorName)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleEnglishNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = Constants.subtitleEnglishNameLabelNumberOfLines
        label.font = UIFont.boldText
        label.textColor = UIColor(named: Constants.grayTextColorName)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var countEpisodesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldText
        label.textColor = UIColor(named: Constants.primaryColorName)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingView: StarsRatingView = {
        let view = StarsRatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleRussianNameLabel)
        contentView.addSubview(subtitleEnglishNameLabel)
        contentView.addSubview(countEpisodesLabel)
        contentView.addSubview(ratingView)
        contentView.addSubview(separatorView)
    }
    
    // MARK: Constraints
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: appearance.xxsSpace
            ),
            posterImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: appearance.sSpace
            ),
            posterImageView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -appearance.xxsSpace
            ),
            posterImageView.heightAnchor.constraint(
                equalToConstant: appearance.posterImageViewHeight
            ),
            posterImageView.widthAnchor.constraint(
                equalTo: posterImageView.heightAnchor
            ),
            
            titleRussianNameLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: appearance.sSpace - 4
            ),
            titleRussianNameLabel.leadingAnchor.constraint(
                equalTo: posterImageView.trailingAnchor,
                constant: appearance.sSpace
            ),
            titleRussianNameLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -appearance.sSpace
            ),
            
            subtitleEnglishNameLabel.topAnchor.constraint(
                equalTo: titleRussianNameLabel.bottomAnchor
            ),
            subtitleEnglishNameLabel.leadingAnchor.constraint(
                equalTo: titleRussianNameLabel.leadingAnchor
            ),
            subtitleEnglishNameLabel.trailingAnchor.constraint(
                equalTo: titleRussianNameLabel.trailingAnchor
            ),
            subtitleEnglishNameLabel.bottomAnchor.constraint(
                lessThanOrEqualTo: countEpisodesLabel.topAnchor,
                constant: -(appearance.xxsSpace - 3)
            ),
            
            ratingView.topAnchor.constraint(
                greaterThanOrEqualTo: subtitleEnglishNameLabel.bottomAnchor,
                constant: appearance.xxxsSpace + 1
            ),
            ratingView.leadingAnchor.constraint(
                equalTo: subtitleEnglishNameLabel.leadingAnchor
            ),
            ratingView.bottomAnchor.constraint(
                equalTo: countEpisodesLabel.bottomAnchor,
                constant: -appearance.xxxsSpace
            ),

            countEpisodesLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -appearance.sSpace
            ),
            countEpisodesLabel.bottomAnchor.constraint(
                equalTo: separatorView.topAnchor,
                constant: -(appearance.xxxsSpace - 2)
            ),
        
            separatorView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            separatorView.heightAnchor.constraint(
                equalToConstant: appearance.separatorViewHeight
            ),
            separatorView.leadingAnchor.constraint(
                equalTo: subtitleEnglishNameLabel.leadingAnchor
            ),
            separatorView.trailingAnchor.constraint(
                equalTo: subtitleEnglishNameLabel.trailingAnchor
            ),
        ])
    }
    
    // MARK: Instance Methods
    
    func configure(with model: PreviewTitleModel) {
        titleRussianNameLabel.setAttributedText(model.russianTitleName, lineHeight: Constants.titleLineHeight)
        subtitleEnglishNameLabel.setAttributedText(model.englishTitleName, lineHeight: Constants.subtitleLineHeight)
        countEpisodesLabel.setAttributedText("\(Constants.epicodesLabelText)\(model.episodesWathed)/\(model.episodesTotal)", lineHeight: Constants.episodesLineHeight)
        ratingView.configure(with: model.rating)
        posterImageView.loadAsyncFrom(
            url: Constants.imagesHostUrlString + model.posterImageString, placeholder: nil
        )
    }
}
