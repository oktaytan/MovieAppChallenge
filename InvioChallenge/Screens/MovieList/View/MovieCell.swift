//
//  MovieCollectionCell.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 2.12.2021.
//

import UIKit

final class MovieCell: BaseCell {
    
    static let id = "MovieCell"
    
    lazy var moviePoster: UIImageView = {
        let poster = UIImageView()
        let image = UIImage(named: "no_photo")
        poster.image = image
        poster.contentMode = .scaleAspectFill
        poster.layer.cornerRadius = 10
        poster.clipsToBounds = true
        return poster
    }()
    
    lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.text = "The Matrix"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .textColor
        return label
    }()
    
    lazy var movieYear: UILabel = {
        let label = UILabel()
        label.text = "1993"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .textColor
        return label
    }()
    
    lazy var movieType: UILabel = {
        let label = UILabel()
        label.text = "Movie"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .textColor
        return label
    }()
    
    lazy var movieID: UILabel = {
        let label = UILabel()
        label.text = "IMDB ID : tt233246"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .subTextColor
        return label
    }()
    
    lazy var leftStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    override func setupViews() {
        addSubview(moviePoster)
        
        leftStackView.addArrangedSubview(movieTitle)
        leftStackView.addArrangedSubview(movieYear)
        leftStackView.addArrangedSubview(movieType)
        leftStackView.addArrangedSubview(movieID)
        
        addSubview(leftStackView)
        
        moviePoster.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: nil, padding: .init(top: 0, left: 24, bottom: 0, right: 24))
        moviePoster.constraintWidth(100)
        
        leftStackView.anchor(top: topAnchor, bottom: bottomAnchor, leading: moviePoster.trailingAnchor, trailing: trailingAnchor, padding: .init(top: 12, left: 24, bottom: 12, right: 24))
        
    }
}
