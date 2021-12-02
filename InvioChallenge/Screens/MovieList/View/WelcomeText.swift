//
//  WelcomeText.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 2.12.2021.
//

import UIKit

final class WelcomeText: UIStackView {
    
    init() {
        super.init(frame: .zero)
        setupHierarchy()
        setupLayout()
    }
    
    lazy var helloText: UILabel = {
        let label = UILabel()
        label.text = "Hello Oktay"
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .textColor
        return label
    }()
    
    lazy var searchText: UILabel = {
        let label = UILabel()
        label.text = "Find your favorite movies"
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .subTextColor
        return label
    }()
    
    fileprivate func setupHierarchy() {
        self.addArrangedSubview(helloText)
        self.addArrangedSubview(searchText)
    }
    
    fileprivate func setupLayout() {
        self.axis = .vertical
        self.distribution = .equalSpacing
        self.constraintHeight(60)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
