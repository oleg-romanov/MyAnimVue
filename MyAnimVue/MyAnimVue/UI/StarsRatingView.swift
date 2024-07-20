//
//  StarsRatingView.swift
//  MyAnimVue
//
//  Created by Олег Романов on 13.07.2024.
//

import UIKit

final class StarsRatingView: UIView {
    
    // MARK: Constants
    
    private enum Constants {
        static let starFillIconName: String = "starFill"
        static let starPastIconName: String = "starPast"
        static let starVoidIconName: String = "starVoid"
        
        static let ratingStarsStackViewSpacing: CGFloat = 1
    }
    
    // MARK: Instance Properties
    
    private var maxRating: Int
    
    private var ratingStarsImageViews: [UIImageView] = []
    
    private lazy var ratingStarsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.ratingStarsStackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: Initializers
    
    init(maxRating: Int = 10) {
        self.maxRating = maxRating
        super.init(frame: .zero)
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
        let localMaxRating = maxRating / 2
        for _ in 0..<localMaxRating {
            let starImageView: UIImageView = UIImageView()
            ratingStarsImageViews.append(starImageView)
            ratingStarsStackView.addArrangedSubview(starImageView)
        }
    }
    
    private func addSubviews() {
        addSubview(ratingStarsStackView)
    }
    
    // MARK: Constraints
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            ratingStarsStackView.topAnchor.constraint(
                equalTo: topAnchor
            ),
            ratingStarsStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            ratingStarsStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            ratingStarsStackView.bottomAnchor.constraint(
                equalTo: bottomAnchor
            ),
        ])
    }
    
    // MARK: Instance Methods
    
    func configure(with rating: Double) {
        var i = 0
        let starsAll = maxRating / 2
        let partsOfNumber = fetchStarsCount(from: rating)
        
        let intPart = partsOfNumber.intPart
        let decPart = partsOfNumber.decPart
        
        while (i < starsAll) {
            
            if (i < intPart) {
                ratingStarsImageViews[i].image = UIImage(named: Constants.starFillIconName)
            } else if (i == intPart && decPart == 5) {
                ratingStarsImageViews[i].image = UIImage(named: Constants.starPastIconName)
            } else {
                ratingStarsImageViews[i].image = UIImage(named: Constants.starVoidIconName)
            }
            i += 1
        }
    }
    
    private func fetchStarsCount(from rating: Double) -> (intPart: Int, decPart: Int) {
        let currentRating: Double = rating / 2
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        
        guard
            let formattedNumberSequence = formatter.string(from: NSNumber(value: currentRating))?.split(separator: ","),
            let intPartString = formattedNumberSequence.first,
            let decPartString = formattedNumberSequence.last,
            let decPart = Int(decPartString),
            let intPart = Int(intPartString)
        else {
            fatalError()
        }
        
        var finalIntPart = intPart
        var finalDecPart = 0

        switch decPart {
            case 3...7:
                finalDecPart = 5
            case 8...10:
                finalIntPart += 1
            default:
                break
        }

        return (intPart: finalIntPart, decPart: finalDecPart)
    }
}
