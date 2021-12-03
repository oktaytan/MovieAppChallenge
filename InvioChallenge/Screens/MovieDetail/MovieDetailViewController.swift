//
//  MovieDetailViewController.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    var movieDetail: MovieDetail? {
        didSet {
            guard let detail = movieDetail else { return }
            detailTopNavigationView.movieTitle.text = detail.title
            if let rate = Double(detail.imdbRating) {
                self.movieRating.rating = rate
            }
            
            app.service.fetchMoviePoster(urlString: detail.poster) { image, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                DispatchQueue.main.async {
                    self.moviePoster.image = image ?? UIImage(named: "no_photo")
                }
            }
        }
    }
    
    let detailTopNavigationView = DetailTopNavigationView()
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
    
    var viewModel: MovieDetailViewModel? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    fileprivate func setupView() {
        
    }
    
    fileprivate func setupHierarchy() {
        view.addSubview(detailTopNavigationView)
        view.addSubview(moviePoster)
        view.addSubview(movieRating)
    }
    
    fileprivate func setupLayout() {
        detailTopNavigationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 24, bottom: 0, right: 24))
        detailTopNavigationView.constraintHeight(44)
        
        moviePoster.anchor(top: detailTopNavigationView.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 42, left: 0, bottom: 0, right: 0))
        moviePoster.centerXSuperView()
        moviePoster.constraintWidth(260)
        moviePoster.constraintHeight(320)
        
        movieRating.anchor(top: moviePoster.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 34, left: 0, bottom: 0, right: 0))
        movieRating.centerXSuperView()
        movieRating.constraintWidth(100)
        movieRating.constraintHeight(20)
    }
}
