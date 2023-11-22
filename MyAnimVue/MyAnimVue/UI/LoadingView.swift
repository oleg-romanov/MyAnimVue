//
//  LoadingView.swift
//  MyAnimVue
//
//  Created by Олег Романов on 22.11.2023.
//

import UIKit

final class LoadingView: UIView {
    
    // MARK: - Instance Properties
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .medium
        return activityIndicator
    }()
    
    // MARK:  Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(activityIndicator)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func setup() {
        activityIndicator.startAnimating()
    }
}
