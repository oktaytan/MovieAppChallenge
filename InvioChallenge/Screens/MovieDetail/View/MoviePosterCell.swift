//
//  MoviePosterCell.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 4.12.2021.
//

import UIKit

final class MoviePosterCell: BaseCell {
    
    static let id = "MoviePosterCell"
    
    var cellInfo: PosterCellInfo? {
        didSet {
            guard let info = cellInfo else { return }
            self.movieRating.rating = Double(info.rate)!
            self.moviePoster.image = info.posterImage ?? UIImage(named: "no_photo")
            self.duration.text = info.duration
            self.release.text = info.release.components(separatedBy: "–")[0]
            self.language.text = info.language.components(separatedBy: ",")[0]
        }
    }
    
    let movieRating = MovieRating()
    
    lazy var durationTitle: UILabel = {
        let label = UILabel()
        label.text = "Duration"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.textColor = .subTextColor
        return label
    }()
    
    lazy var duration: UILabel = {
        let label = UILabel()
        label.text = "--- min"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .textColor
        return label
    }()
    
    lazy var durationStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    lazy var releaseTitle: UILabel = {
        let label = UILabel()
        label.text = "Year"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.textColor = .subTextColor
        return label
    }()
    
    lazy var release: UILabel = {
        let label = UILabel()
        label.text = "----"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .textColor
        return label
    }()
    
    lazy var releaseStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    lazy var languageTitle: UILabel = {
        let label = UILabel()
        label.text = "Language"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.textColor = .subTextColor
        return label
    }()
    
    lazy var language: UILabel = {
        let label = UILabel()
        label.text = "----"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .textColor
        return label
    }()
    
    lazy var languageStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    lazy var moviePoster: UIImageView = {
        let poster = UIImageView()
        let image = UIImage(named: "no_photo")
        poster.image = image
        poster.contentMode = .scaleAspectFill
        poster.layer.cornerRadius = 24
        poster.clipsToBounds = true
        return poster
    }()
    
    lazy var wrapStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.backgroundColor = .none
        return stack
    }()
    
    override func setupViews() {
        backgroundColor = .clear
        movieRating.rating = 0.0
        
        addSubview(moviePoster)
        
        moviePoster.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: nil, padding: .init(top: 42, left: 24, bottom: 0, right: 0))
        moviePoster.constraintWidth(200)
        moviePoster.constraintHeight(245)
        
        durationStackView.addArrangedSubview(duration)
        durationStackView.addArrangedSubview(durationTitle)
        durationStackView.constraintWidth(100)
        durationStackView.constraintHeight(44)
        
        releaseStackView.addArrangedSubview(release)
        releaseStackView.addArrangedSubview(releaseTitle)
        releaseStackView.constraintWidth(100)
        releaseStackView.constraintHeight(44)
        
        languageStackView.addArrangedSubview(language)
        languageStackView.addArrangedSubview(languageTitle)
        languageStackView.constraintWidth(100)
        languageStackView.constraintHeight(44)
        
        movieRating.constraintWidth(85)
        movieRating.constraintHeight(16)
        
        wrapStackView.addArrangedSubview(durationStackView)
        wrapStackView.addArrangedSubview(releaseStackView)
        wrapStackView.addArrangedSubview(languageStackView)
        wrapStackView.addArrangedSubview(movieRating)
        addSubview(wrapStackView)
        
        wrapStackView.anchor(top: moviePoster.topAnchor, bottom: moviePoster.bottomAnchor, leading: moviePoster.trailingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
    }
}
