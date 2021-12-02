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
    
    override func viewDidLoad() {
        setupView()
        setupHierarchy()
        setupLayout()
        
        searchField.delegate = self
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .white
    }
    
    fileprivate func setupHierarchy() {
        view.addSubview(topMenu)
        view.addSubview(welcomeText)
        view.addSubview(searchField)
    }
    
    fileprivate func setupLayout() {
        topMenu.centerXSuperView()
        topMenu.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 24, bottom: 0, right: 24))
        topMenu.constraintHeight(45)
        
        welcomeText.anchor(top: topMenu.bottomAnchor, bottom: nil, leading: topMenu.leadingAnchor, trailing: nil, padding: .init(top: 32, left: 0, bottom: 0, right: 0))
        
        searchField.anchor(top: welcomeText.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 21, left: 24, bottom: 0, right: 24))
    }
    
}

extension MovieListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        searchBar.setShowsCancelButton(true, animated: true)
        
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("test")
    }
    
    
}
