//
//  MovieListViewController.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    var viewModel: MovieListViewModel!
    
    let topMenu = TopNavigationView()
    let welcomeText = WelcomeText()
    let searchField = SearchField()
    let loadingView = LoadingIndicatorView()
    let notFoundView = MovieNotFoundView()
    var searchFieldTopAnchor: NSLayoutConstraint?
    
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                self.recentlyTitle.alpha = 0
                self.recentlyCollection.alpha = 0
            } else {
                self.recentlyTitle.alpha = 1
                self.recentlyCollection.alpha = 1
            }
        }
    }
    
    var movies: [Movie] = []
    
    lazy var searchDescription: UILabel = {
        let label = UILabel()
        label.text = "Type the name of the movie you want to search"
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .center
        label.textColor = .subTextColor
        label.numberOfLines = 2
        label.alpha = 0
        return label
    }()
    
    lazy var recentlyTitle: UILabel = {
        let label = UILabel()
        label.text = "Recently searches"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .textColor
        return label
    }()
    
    lazy var recentlyCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.contentInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        return collectionView
    }()
    
    override func viewDidLoad() {
        setupView()
        setupHierarchy()
        setupLayout()
        
        searchField.delegate = self
        
        recentlyCollection.delegate = self
        recentlyCollection.dataSource = self
        recentlyCollection.register(MovieCollectionCell.self, forCellWithReuseIdentifier: MovieCollectionCell.cellID)
        
        self.isLoading = true
        self.loadingView.isLoading = true
        
        app.service.fetchMovies(for: "matrix", page: 1) { search, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let movies = search, let results = movies.results else { return }
            DispatchQueue.main.async {
                self.movies = results
                self.recentlyCollection.reloadData()
                self.isLoading = false
                self.loadingView.isLoading = false
            }
        }
    }
    
    fileprivate func notFoundShow() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.recentlyTitle.alpha = 0
            self.recentlyCollection.alpha = 0
            self.view.addSubview(self.notFoundView)
        } completion: { _ in
            self.recentlyTitle.removeFromSuperview()
            self.recentlyCollection.removeFromSuperview()
            self.notFoundView.alpha = 1
        }
    }
    
    fileprivate func notFoundHide() {
        UIView.animate(withDuration: 0.3, delay: 5, options: .curveEaseInOut) {
            self.notFoundView.alpha = 0
            self.recentlyTitle.alpha = 1
            self.recentlyCollection.alpha = 1
        } completion: { _ in
            self.notFoundView.removeFromSuperview()
        }
    }
    
}
