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
    }
    
    private struct Appearance: Grid {
        let applicationLogoWidth: CGFloat = 150
        let applicationLogoTopAnchor: CGFloat = 90
        let titleLabelTopAnchor: CGFloat = 60
    }
    
    // MARK: Instance Properties
    
    var presenter: ProfilePresentationLogic!
    
    private let appearance = Appearance()
    
    private lazy var headerView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.tableHeaderView = headerView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addSubviews()
        makeConstraints()
    }
    
    // MARK: Setup
    
    private func setup() {
        view.backgroundColor = UIColor(named: Constants.backgroundColor)
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    // MARK: Constraints
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
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
        ])
    }
}

extension ProfileViewController: ProfileDisplayLogic {
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
