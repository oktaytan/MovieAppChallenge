//
//  MovieRating.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 3.12.2021.
//

import UIKit

final class MovieRating: UIStackView {
    
    var rating: Double = 0 {
        didSet {
            
            let rate = round(rating / 2)
            for (index, item) in subviews.enumerated() {
                for i in 0...Int(rate) {
                    if index == i {
                        item.tintColor = .secondaryColor
                    }
                }
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupHierarchy()
        setupLayout()
    }
    
    lazy var star1: UIImageView = {
        let view = UIImageView()
        let largeFont = UIFont.systemFont(ofSize: 24)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "star.fill", withConfiguration: configuration)
        view.image = image
        view.tintColor = .bgColor
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var star2: UIImageView = {
        let view = UIImageView()
        let largeFont = UIFont.systemFont(ofSize: 24)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "star.fill", withConfiguration: configuration)
        view.image = image
        view.tintColor = .bgColor
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var star3: UIImageView = {
        let view = UIImageView()
        let largeFont = UIFont.systemFont(ofSize: 24)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "star.fill", withConfiguration: configuration)
        view.image = image
        view.tintColor = .bgColor
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var star4: UIImageView = {
        let view = UIImageView()
        let largeFont = UIFont.systemFont(ofSize: 24)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "star.fill", withConfiguration: configuration)
        view.image = image
        view.tintColor = .bgColor
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var star5: UIImageView = {
        let view = UIImageView()
        let largeFont = UIFont.systemFont(ofSize: 24)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "star.fill", withConfiguration: configuration)
        view.image = image
        view.tintColor = .bgColor
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    fileprivate func setupHierarchy() {
        self.addArrangedSubview(star1)
        self.addArrangedSubview(star2)
        self.addArrangedSubview(star3)
        self.addArrangedSubview(star4)
        self.addArrangedSubview(star5)
    }
    
    fileprivate func setupLayout() {
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.spacing = 0
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
