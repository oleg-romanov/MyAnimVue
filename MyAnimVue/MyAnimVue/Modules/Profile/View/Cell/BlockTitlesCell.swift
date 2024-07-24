//
//  BlockTitlesCell.swift
//  MyAnimVue
//
//  Created by Олег Романов on 06.07.2024.
//

import UIKit

final class BlockTitlesCell: UITableViewCell {
    
    // MARK: Constants
    
    private enum Constants {
        static let lightGrayColorName: String = "LightGrayColor"
        
        static let previewTitleCellIdentifier: String = "PreviewTitleCell"
        
        static let layoutMinimumLineSpacing: CGFloat = 0
        static let layoutMinimumInteritemSpacing: CGFloat = 0
    }
    
    // MARK: Appearance
    
    private struct Appearance: Grid {
        /// = 2
        let separatorViewHeight: CGFloat = 2
        /// = 98
        let collectionViewItemHeight: CGFloat = 98
        /// = 294
        let collectionViewInitialHeight: CGFloat = 294
    }

    // MARK: Instance Properties
    
    private let appearance = Appearance()
    
    private var collectionViewHeightConstraint: NSLayoutConstraint!
    
    private var data: [PreviewTitleModel] = []
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Constants.layoutMinimumLineSpacing
        layout.minimumInteritemSpacing = Constants.layoutMinimumInteritemSpacing
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(PreviewTitleCell.self, forCellWithReuseIdentifier: Constants.previewTitleCellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
        contentView.addSubview(collectionView)
        contentView.addSubview(separatorView)
    }
    
    // MARK: Constraints
    
    private func makeConstraints() {
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(
            equalToConstant: appearance.collectionViewInitialHeight
        )
        collectionViewHeightConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            collectionViewHeightConstraint,
            
            collectionView.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: separatorView.bottomAnchor,
                constant: -appearance.mSpace
            ),

            separatorView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: appearance.mSpace
            ),
            separatorView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -appearance.mSpace
            ),
            separatorView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            separatorView.heightAnchor.constraint(
                equalToConstant: appearance.separatorViewHeight - 1
            ),
        ])
    }
    
    // MARK: Instance Methods
    
    func configure(with model: [PreviewTitleModel]) {
        data = model
        
        var height: CGFloat = 0.0
        
        switch model.count {
            case 1:
                height = appearance.collectionViewItemHeight
            case 2:
                height = appearance.collectionViewItemHeight * 2
            default:
                height = appearance.collectionViewItemHeight * 3
        }
        
        updateCollectionViewHeight(to: height)
        collectionView.reloadData()
    }
    
    private func updateCollectionViewHeight(to height: CGFloat) {
        collectionViewHeightConstraint.constant = height
        contentView.layoutIfNeeded()
    }
}

// MARK: - UICollectionViewDataSource

extension BlockTitlesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.previewTitleCellIdentifier,
            for: indexPath
        ) as? PreviewTitleCell 
        else {
            return UICollectionViewCell()
        }
        cell.configure(with: data[indexPath.item])
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BlockTitlesCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = appearance.collectionViewItemHeight
        return CGSize(width: width, height: height)
    }
}
