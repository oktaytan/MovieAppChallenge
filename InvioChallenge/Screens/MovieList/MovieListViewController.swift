//
//  MovieListViewController.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import UIKit

final class MovieListViewController: UICollectionViewController {
    
    var viewModel: MovieListViewModel!
    var loadingView = LoadingIndicatorView()
    var notFoundView = MovieNotFoundView()
    var userDefaults = UserDefaults.standard
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        
        
        if let lastTitle = userDefaults.value(forKey: app.userDefaultsKey) as? String {
            collectionView.subviews.forEach { item in
                guard let cell = item as? MovieListCell else { return }
                cell.isHidden = true
            }
            
            loadingView.isHidden = false
            loadingView.isLoading = true
            viewModel.fetchMovies(title: lastTitle) { [weak self] (search, error) in
                guard let self = self else { return }
                
                if let error = error {
                    self.loadingView.isLoading = false
                    self.loadingView.isHidden = true
                    self.notFoundView.isHidden = false
                    self.notFoundView.notFoundText.text = error.description
                } else {
                    guard let data = search, let results = data.results else { return }
                    self.movies = results
                    self.loadingView.isLoading = false
                    self.loadingView.isHidden = true
                    self.collectionView.subviews.forEach { item in
                        guard let cell = item as? MovieListCell else { return }
                        cell.isHidden = false
                    }
                    self.collectionView.reloadData()
                }
            }
        }
        
    }
    
    func setupView() {
        view.backgroundColor = .white
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceVertical = true
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(endingSearch))
        swipeGesture.direction = .down
        swipeGesture.numberOfTouchesRequired = 1
        collectionView.addGestureRecognizer(swipeGesture)
        
        collectionView.register(HeaderListCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderListCell.id)
        collectionView.register(MovieListCell.self, forCellWithReuseIdentifier: MovieListCell.id)
    }
    
    func setupHierarchy() {
        collectionView.addSubview(notFoundView)
        collectionView.addSubview(loadingView)
    }
    
    func setupLayout() {
        notFoundView.centerWithSuperview(size: .init(width: 200, height: 200))
        notFoundView.isHidden = true
        
        loadingView.centerWithSuperview()
        loadingView.isHidden = true
    }
}



// MARK: - CollectionView Delegation
extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCell.id, for: indexPath) as? MovieListCell else { return UICollectionViewCell() }
        
        let movie = self.movies[indexPath.item]
        cell.movie = movie
        viewModel.fetchMoviePoster(urlString: movie.poster) { image in
            if let poster = image as? UIImage {
                cell.moviePoster.image = image
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 122)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderListCell.id, for: indexPath) as? HeaderListCell else { return UICollectionReusableView() }
            header.delegate = self
            return header
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 280)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieID = self.movies[indexPath.item].id
        app.router.goToDetail(movieID)
    }
}


