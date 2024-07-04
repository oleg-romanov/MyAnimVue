//
//  OnboardingViewController.swift
//  MyAnimVue
//
//  Created by Олег Романов on 04.07.2024.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let imageLogoName: String = "AppLogoMini"
        static let viewBackgroundColorName = "AnimvueBackgroundColor"
        static let inactivePageIndicatorTintColorName = "SystemLightGrayColor"
        static let currentPageIndicatorTintColorName = "PrimaryColor"
        static let nextButtonTitleText: String = "Далее"
        static let nextButtonFinallyTitleText: String = "Приступим!"
        static let slideCellIdentifier: String = "SlideCell"
    }
    
    // MARK: Appearance
    
    private struct Appearance: Grid {
        let applicationLogoWidth: CGFloat = 150
        let applicationLogoTopAnchor: CGFloat = 90
        let titleLableTopAnchor: CGFloat = 60
        let startButtonHeight: CGFloat = 60
    }
    
    // MARK: Instance Properties
    
    var presenter: OnboardingPresentationLogic!
    
    private let appearance = Appearance()
    
    private var data: [Slide] = Slide.generateSlides()
    
    private var pageNumber: Int = 0 {
        willSet {
            if newValue == data.count - 1 {
                nextButton.setFinalState()
            } else {
                nextButton.setOriginalTitle()
            }
        }
    }
    
    private lazy var applicationLogoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.imageLogoName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SlideCell.self, forCellWithReuseIdentifier: Constants.slideCellIdentifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = UIColor(named: Constants.inactivePageIndicatorTintColorName)
        pageControl.currentPageIndicatorTintColor = UIColor(named: Constants.currentPageIndicatorTintColorName)
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private lazy var nextButton: NextButton = {
        let button = NextButton(title: Constants.nextButtonTitleText)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonDidPress), for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        makeConstraints()
    }
    
    // MARK: Setup
    
    private func setupView() {
        view.backgroundColor = UIColor(named: Constants.viewBackgroundColorName)
        pageControl.numberOfPages = data.count
    }
    
    private func addSubviews() {
        view.addSubview(applicationLogoView)
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
    }
    
    // MARK: Constraints
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            applicationLogoView.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                constant: appearance.xxxlSpace + 4
            ),
            applicationLogoView.widthAnchor.constraint(
                equalToConstant: appearance.applicationLogoWidth
            ),
            applicationLogoView.heightAnchor.constraint(
                equalTo: applicationLogoView.widthAnchor
            ),
            applicationLogoView.centerXAnchor.constraint(
                equalTo: self.view.centerXAnchor
            ),
            
            collectionView.topAnchor.constraint(
                equalTo: applicationLogoView.bottomAnchor
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: pageControl.topAnchor
            ),
            
            pageControl.bottomAnchor.constraint(
                equalTo: nextButton.topAnchor,
                constant: -(appearance.xxlSpace - 2)
            ),
            pageControl.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            
            nextButton.heightAnchor.constraint(
                equalToConstant: appearance.startButtonHeight
            ),
            nextButton.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor,
                constant: appearance.mSpace + 4
            ),
            nextButton.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor,
                constant:  -(appearance.mSpace + 4)
            ),
            nextButton.bottomAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                constant: -appearance.xxsSpace
            )
        ])
    }
    
    // MARK: Actions
    
    @objc private func nextButtonDidPress() {
        if (pageNumber == data.count - 1) {
            presenter.nextButtonInFinalStateDidPress()
        } else {
            nextPage()
        }
    }
    
    // MARK: Instance Methods
    
    private func nextPage() {
        guard pageNumber < data.count - 1 else { return }
        let indexPath = IndexPath(item: pageNumber + 1, section: .zero)
        collectionView.scrollToItem(
            at: indexPath,
            at: .centeredHorizontally,
            animated: true
        )
    }
}

// MARK: - UICollectionViewDataSource

extension OnboardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.slideCellIdentifier,
            for: indexPath
        ) as? SlideCell
        let item = data[indexPath.item]
        cell?.configure(slide: item)
        
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate

extension OnboardingViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let halfOfScreen: CGFloat = UIScreen.main.bounds.width / 2
        let nextPagePosition: CGFloat = scrollView.contentOffset.x + halfOfScreen
        let currentIndex = Int(nextPagePosition / UIScreen.main.bounds.width)
        if currentIndex != pageNumber {
            pageNumber = currentIndex
            pageChanged(page: pageNumber)
        }
    }
    
    func pageChanged(page: Int) {
        pageControl.currentPage = page
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}
