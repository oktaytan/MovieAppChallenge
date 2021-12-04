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
            self.calcRate(at: rating)
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupHierarchy()
        setupLayout()
    }
    
    fileprivate func setupHierarchy() {
        self.setStar()
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

// MARK: - Local functions
extension MovieRating {
    fileprivate func calcRate(at rating: Double) {
        let rate = round(rating / 2)
        for (index, item) in subviews.enumerated() {
            for i in 0...Int(rate) {
                if index == (i - 1) {
                    item.tintColor = .secondaryColor
                }
            }
        }
    }
    
    fileprivate func setStar() {
        for _ in 0...4  {
            let star = UIImageView()
            let largeFont = UIFont.systemFont(ofSize: 24)
            let configuration = UIImage.SymbolConfiguration(font: largeFont)
            let image = UIImage(systemName: "star.fill", withConfiguration: configuration)
            star.image = image
            star.tintColor = .bgColor
            star.contentMode = .scaleAspectFit
            
            self.addArrangedSubview(star)
        }
    }
}
