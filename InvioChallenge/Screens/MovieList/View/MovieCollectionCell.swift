//
//  MovieCollectionCell.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 2.12.2021.
//

import UIKit

final class MovieCollectionCell: BaseCollectionViewCell {
    
    static let cellID = "MovieCollectionCellID"
    private var isLike: Bool = false
    
    var movie: Movie? {
        didSet {
            
            guard let movie = movie else { return }
            movieTitle.text = movie.title
            movieYear.text = movie.year
            
            app.service.fetchMoviePoster(urlString: movie.poster) { image, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self.moviePoster.image = image
            }
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
        label.font = .preferredFont(forTextStyle: .callout)
        label.textColor = .textColor
        return label
    }()
    
    lazy var movieYear: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .subTextColor
        return label
    }()
    
    lazy var likeButton: UIButton = {
        let btn = UIButton(type: .custom)
        let largeFont = UIFont.systemFont(ofSize: 20)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "star.fill", withConfiguration: configuration)
        btn.setBackgroundImage(image, for: .normal)
        btn.tintColor = self.isLike ? .secondaryColor : .bgColor
        btn.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(like), for: .touchUpInside)
        return btn
    }()
    
    override func setupViews() {
        addSubview(moviePoster)
        addSubview(movieTitle)
        addSubview(movieYear)
        addSubview(likeButton)
        
        moviePoster.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor)
        moviePoster.constraintWidth(190)
        moviePoster.constraintHeight(234)
        
        movieTitle.anchor(top: moviePoster.bottomAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 24))
        
        movieYear.anchor(top: movieTitle.bottomAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 3, left: 0, bottom: 0, right: 0))
        
        likeButton.anchor(top: moviePoster.bottomAnchor, bottom: nil, leading: nil, trailing: trailingAnchor, padding: .init(top: 14, left: 0, bottom: 0, right: 0))
    }
    
    @objc func like() {
        self.isLike.toggle()
        self.likeButton.tintColor = self.isLike ? .secondaryColor : .bgColor
    }
    
}
