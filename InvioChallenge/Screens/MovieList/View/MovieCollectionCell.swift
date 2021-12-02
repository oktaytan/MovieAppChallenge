//
//  MovieCollectionCell.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 2.12.2021.
//

import UIKit

final class MovieCollectionCell: BaseCollectionViewCell {
    
    static let cellID = "MovieCollectionCellID"
    
    var movie: Movie? {
        didSet {
            
        }
    }
    
    lazy var moviePoster: UIImageView = {
        let poster = UIImageView()
        let image = UIImage(named: "no_photo")
        poster.image = image
        poster.contentMode = .scaleAspectFit
        poster.layer.cornerRadius = 10
        poster.clipsToBounds = true
        return poster
    }()
    
    override func setupViews() {
        addSubview(moviePoster)
        moviePoster.constraintWidth(190)
        moviePoster.constraintHeight(234)
    }
    
}
