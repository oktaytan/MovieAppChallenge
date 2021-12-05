//
//  MovieListCell.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 2.12.2021.
//

import UIKit

final class MovieListCell: BaseCell {
    
    static let id = "MovieListCell"
    
    var movie: Movie? {
        didSet {
            guard let mv = movie else { return }
            movieTitle.text = mv.title
            movieYear.text = mv.year
            movieType.text = mv.type.capitalized
            movieID.text = "IMDB ID : \(mv.id)"
        }
    }
    
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
        label.text = "No name"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .textColor
        return label
    }()
    
    lazy var movieYear: UILabel = {
        let label = UILabel()
        label.text = "----"
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
        label.text = "IMDB ID : ---------"
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
