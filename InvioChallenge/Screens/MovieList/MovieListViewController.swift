//
//  MovieListViewController.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import UIKit

final class MovieListViewController: UICollectionViewController {
    
    var viewModel: MovieListViewModel!
    
    var movies: [Movie] = [
        .init(id: "1", title: "The Matrix", year: "1993", type: "Movie", poster: "https://m.media-amazon.com/images/M/MV5BNzQzOTk3OTAtNDQ0Zi00ZTVkLWI0MTEtMDllZjNkYzNjNTc4L2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg"),
        .init(id: "2", title: "The Matrix Reloaded", year: "2003", type: "Movie", poster: "https://m.media-amazon.com/images/M/MV5BODE0MzZhZTgtYzkwYi00YmI5LThlZWYtOWRmNWE5ODk0NzMxXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg"),
        .init(id: "3", title: "The Matrix Revolutions", year: "2003", type: "Movie", poster: "https://m.media-amazon.com/images/M/MV5BNzNlZTZjMDctZjYwNi00NzljLWIwN2QtZWZmYmJiYzQ0MTk2XkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_SX300.jpg"),
        .init(id: "4", title: "The Matrix Revisited", year: "2001", type: "Movie", poster: "https://m.media-amazon.com/images/M/MV5BMTkzNjg3NjE4N15BMl5BanBnXkFtZTgwNTc3NTAwNzE@._V1_SX300.jpg")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    func setupView() {
        view.backgroundColor = .white
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceVertical = true
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(endingSearch))
        swipeGesture.direction = .down
        swipeGesture.numberOfTouchesRequired = 1
        collectionView.addGestureRecognizer(swipeGesture)
        
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.id)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.id)
    }
    
    func setupHierarchy() {
        
    }
    
    func setupLayout() {
        
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
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.id, for: indexPath) as? MovieCell else { return UICollectionViewCell() }
        cell.movie = self.movies[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 122)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.id, for: indexPath) as? HeaderCell else { return UICollectionReusableView() }
            header.delegate = self
            return header
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 280)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        app.router.goToDetail("1")
    }
}



extension MovieListViewController: SearchBarActiveDelegation {
    
    func searchBegin() {
        collectionView.isScrollEnabled = false
        collectionView.subviews.forEach { item in
            if let cell = item as? MovieCell {
                cell.isHidden = true
            }
        }
    }
    
    func searchEnd() {
        collectionView.isScrollEnabled = true
        collectionView.subviews.forEach { item in
            if let cell = item as? MovieCell {
                cell.isHidden = false
            }
        }
    }
    
    @objc func endingSearch() {
        collectionView.subviews.forEach { item in
            if let cell = item as? HeaderCell {
                cell.closeSearch(cell.searchField)
            }
        }
    }
    
}

