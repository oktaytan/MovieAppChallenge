//
//  MoviePosterCell.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 4.12.2021.
//

import UIKit

final class MoviePosterCell: BaseCell {
    
    static let id = "MoviePosterCell"
    
    var duration = UITextView()
    var release = UITextView()
    var language = UITextView()
    let movieRating = MovieRating()
    lazy var moviePoster: UIImageView = {
        let poster = UIImageView()
        let image = UIImage(named: "no_photo")
        poster.image = image
        poster.contentMode = .scaleAspectFill
        poster.layer.cornerRadius = 24
        poster.clipsToBounds = true
        return poster
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.backgroundColor = .none
        return stack
    }()
    
    override func setupViews() {
        backgroundColor = .clear
        duration = self.setAttributedText(for: "136 min", at: "Duration")
        release = self.setAttributedText(for: "1999", at: "Release")
        language = self.setAttributedText(for: "English", at: "Language")
        movieRating.rating = 7.2
        
        stackView.addArrangedSubview(duration)
        stackView.addArrangedSubview(release)
        stackView.addArrangedSubview(language)
        stackView.addArrangedSubview(movieRating)
        
        addSubview(moviePoster)
        addSubview(stackView)
        
        moviePoster.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: nil, padding: .init(top: 42, left: 24, bottom: 0, right: 0))
        moviePoster.constraintWidth(200)
        moviePoster.constraintHeight(245)
        
        duration.constraintWidth(100)
        duration.constraintHeight(60)
        
        release.constraintWidth(100)
        release.constraintHeight(60)
        
        language.constraintWidth(100)
        language.constraintHeight(60)
        
        movieRating.constraintWidth(85)
        movieRating.constraintHeight(16)
        
        stackView.anchor(top: moviePoster.topAnchor, bottom: moviePoster.bottomAnchor, leading: moviePoster.trailingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 0))
    }
    
}
