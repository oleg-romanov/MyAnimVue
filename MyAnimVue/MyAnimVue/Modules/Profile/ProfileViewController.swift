//
//  ProfileViewController.swift
//  MyAnimVue
//
//  Created by Олег Романов on 05.07.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let backgroundColor: String = "AnimvueBackgroundColor"
        static let logoImageName: String = "AppLogoMini"
        static let titleText = "Профиль"
        static let mainTextColor = "MainTextColor"
        static let primaryColor = "PrimaryColor"
        static let accentTextColor = "AccentColor"
        static let clearColor = "ClearColor"
        static let invertedTextColor = "InvertedMainTextColor"
        static let leftSegmentControlItemName = "Shikimori"
        static let rightSegmentControlItemName = "Anilibria"
        
        static let favoriteTitlesCellIdentifier: String = "FavoriteTitlesCell"
        static let blockTitlesCellIdentifier: String = "BlockTitlesCell"
        static let numberOfRowsInSection: Int = 1
    }
    
    private enum TableViewSection: Int, CaseIterable {
        case favorites = 0
    }
    
    private struct Appearance: Grid {
        /// = 150
        let applicationLogoWidth: CGFloat = 150
        /// = 90
        let applicationLogoTopAnchor: CGFloat = 90
        /// = 60
        let titleLabelTopAnchor: CGFloat = 60
        /// = 373
        let headerViewHeight: CGFloat = 373
        /// = 49
        let heightForHeaderInSection: CGFloat = 49
    }
    
    // MARK: Instance Properties
    
    var presenter: ProfilePresentationLogic!
    
    private var data: [[PreviewTitleModel]] = []
    
    private let appearance = Appearance()
    
    private lazy var headerView: ProfileHeaderView = {
        let width = UIScreen.main.bounds.width
        // Frame задан явно, поскольку иначе AutoLayout не успевает сразу просчитать размер header'a таблицы.
        let view = ProfileHeaderView(frame: CGRect(
            x: 0,
            y: 0,
            width: width,
            height: appearance.headerViewHeight)
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(BlockTitlesCell.self, forCellReuseIdentifier: Constants.blockTitlesCellIdentifier)
        tableView.register(FavoriteTitlesCell.self, forCellReuseIdentifier: Constants.favoriteTitlesCellIdentifier)
        tableView.tableHeaderView = headerView
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        addSubviews()
        makeConstraints()
//        tabBarController?.tabBar.barTintColor = .green
//        tabBarController?.tabBar.isTranslucent = false
        Task {
            await presenter.fetchTitlesInfo()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: Setup
    
    private func setupStyle() {
        view.backgroundColor = UIColor(named: Constants.backgroundColor)
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    // MARK: Constraints
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            tableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
            
            headerView.widthAnchor.constraint(
                equalTo: tableView.widthAnchor
            ),
            headerView.heightAnchor.constraint(
                equalToConstant: appearance.headerViewHeight
            ),
            headerView.centerXAnchor.constraint(
                equalTo: tableView.centerXAnchor
            ),
            headerView.topAnchor.constraint(
                equalTo: tableView.topAnchor
            ),
        ])
    }
}

// MARK: - ProfileDisplayLogic

extension ProfileViewController: ProfileDisplayLogic {
    
    func displayTitlesInfo(with models: [[PreviewTitleModel]]) {
        DispatchQueue.main.async {
            self.data = models
            self.tableView.reloadData()
        }
    }
    
    func displayError(with message: String) {
        DispatchQueue.main.async {
            self.showErrorAlert(message: message)
        }
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count + TableViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            case TableViewSection.favorites.rawValue:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Constants.favoriteTitlesCellIdentifier,
                    for: indexPath
                ) as? FavoriteTitlesCell else { return UITableViewCell() }
                
                return cell
                
            default:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Constants.blockTitlesCellIdentifier,
                    for: indexPath
                ) as? BlockTitlesCell else { return UITableViewCell() }
                
                let item = data[indexPath.section - TableViewSection.allCases.count]
                cell.selectionStyle = .none
                cell.configure(with: item)
                
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
            case TableViewSection.favorites.rawValue:
                return .zero
            default:
                return appearance.heightForHeaderInSection
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = data[section - TableViewSection.allCases.count].first else { return nil }
        
        let headerView = ProfileTableSectionHeaderView()
        headerView.configure(blockName: header.blockName, titlesCount: data[section - TableViewSection.allCases.count].count)
        
        switch section {
            case TableViewSection.favorites.rawValue:
                return nil
            default:
                return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
