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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endingSearch))
        view.addGestureRecognizer(tapGesture)
    }
    
    fileprivate func setupHierarchy() {
        view.addSubview(topMenu)
        view.addSubview(welcomeText)
        view.addSubview(searchField)
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
            view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    @objc func endingSearch() {
        self.closeSearch(searchField)
    }
}
