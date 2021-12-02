//
//  MovieListViewController.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    var viewModel: MovieListViewModel!
    
    private let topMenu = TopNavigationView()
    private let welcomeText = WelcomeText()
    private let searchField = SearchField()
    private let loadingView = LoadingIndicatorView()
    
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
    
    lazy var popularTitle: UILabel = {
        let label = UILabel()
        label.text = "Popular"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .textColor
        return label
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endingSearch))
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

extension MovieListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: { [self] in
            topMenu.transform = CGAffineTransform(translationX: 0, y: -30)
            topMenu.alpha = 0
            welcomeText.transform = CGAffineTransform(translationX: 0, y: -30)
            welcomeText.alpha = 0
            searchFieldTopAnchor?.isActive = false
            searchFieldTopAnchor = searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20)
            searchFieldTopAnchor?.isActive = true
            searchDescription.alpha = 1
            recentlyTitle.alpha = 0
            recentlyCollection.alpha = 0
            view.layoutIfNeeded()
        }, completion: nil)

        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.closeSearch(searchBar)
    }
    
    fileprivate func closeSearch(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.searchTextField.resignFirstResponder()
        searchBar.searchTextField.text = ""
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: { [self] in
            topMenu.transform = .identity
            topMenu.alpha = 1
            welcomeText.transform = .identity
            welcomeText.alpha = 1
            searchFieldTopAnchor?.isActive = false
            searchFieldTopAnchor = searchField.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 11)
            searchFieldTopAnchor?.isActive = true
            searchDescription.alpha = 0
            recentlyTitle.alpha = 1
            recentlyCollection.alpha = 1
            view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    @objc func endingSearch() {
        self.closeSearch(searchField)
    }
}


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
        let _ = self.movies[indexPath.item]
    }

    
}
