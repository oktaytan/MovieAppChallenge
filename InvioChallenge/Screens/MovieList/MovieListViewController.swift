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
    
    var movies: [Movie] = [
        .init(id: "1", title: "The Matrix", year: "1993", type: "Movie", poster: "https://m.media-amazon.com/images/M/MV5BNzQzOTk3OTAtNDQ0Zi00ZTVkLWI0MTEtMDllZjNkYzNjNTc4L2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg"),
        .init(id: "2", title: "The Matrix", year: "1993", type: "Movie", poster: "https://m.media-amazon.com/images/M/MV5BNzQzOTk3OTAtNDQ0Zi00ZTVkLWI0MTEtMDllZjNkYzNjNTc4L2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg"),
        .init(id: "3", title: "The Matrix", year: "1993", type: "Movie", poster: "https://m.media-amazon.com/images/M/MV5BNzQzOTk3OTAtNDQ0Zi00ZTVkLWI0MTEtMDllZjNkYzNjNTc4L2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg"),
        .init(id: "4", title: "The Matrix", year: "1993", type: "Movie", poster: "https://m.media-amazon.com/images/M/MV5BNzQzOTk3OTAtNDQ0Zi00ZTVkLWI0MTEtMDllZjNkYzNjNTc4L2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg")
    ]
    
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
        layout.scrollDirection = .horizontal
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
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .white
        let tapGesture = UISwipeGestureRecognizer(target: self, action: #selector(endingSearch))
        tapGesture.direction = .down
        tapGesture.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapGesture)
    }
    
    fileprivate func setupHierarchy() {
        view.addSubview(topMenu)
        view.addSubview(welcomeText)
        view.addSubview(searchField)
        view.addSubview(searchDescription)
        view.addSubview(loadingView)
        view.addSubview(recentlyTitle)
        view.addSubview(recentlyCollection)
    }
    
    var searchFieldTopAnchor: NSLayoutConstraint?
    
    fileprivate func setupLayout() {
        topMenu.centerXSuperView()
        topMenu.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 24, bottom: 0, right: 24))
        topMenu.constraintHeight(45)
        
        welcomeText.anchor(top: topMenu.bottomAnchor, bottom: nil, leading: topMenu.leadingAnchor, trailing: nil, padding: .init(top: 32, left: 0, bottom: 0, right: 0))
        
        searchField.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 14, bottom: 0, right: 14))
        
        searchFieldTopAnchor = searchField.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 11)
        searchFieldTopAnchor?.isActive = true
        
        searchDescription.anchor(top: searchField.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 36, left: 0, bottom: 0, right: 0))
        searchDescription.centerXSuperView()
        searchDescription.constraintWidth(200)
 
        loadingView.centerWithSuperview()
        loadingView.isLoading = false
        
        recentlyTitle.anchor(top: searchField.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 60, left: 24, bottom: 0, right: 24))
        
        recentlyCollection.anchor(top: recentlyTitle.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 0))
        recentlyCollection.constraintHeight(290)
    }
    
}


// MARK: - Recently Searches Delegation
extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionCell.cellID, for: indexPath) as! MovieCollectionCell
        cell.movie = self.movies[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 290)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.movies[indexPath.item]
        print(movie.id)
    }

    
}
