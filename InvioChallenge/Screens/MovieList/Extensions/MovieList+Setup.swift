//
//  MovieList+Setup.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 3.12.2021.
//

import UIKit

extension MovieListViewController {
    
    func setupView() {
        view.backgroundColor = .white
        let tapGesture = UISwipeGestureRecognizer(target: self, action: #selector(endingSearch))
        tapGesture.direction = .down
        tapGesture.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapGesture)
    }
    
    func setupHierarchy() {
        view.addSubview(topMenu)
        view.addSubview(welcomeText)
        view.addSubview(notFoundView)
        view.addSubview(searchField)
        view.addSubview(searchDescription)
        view.addSubview(loadingView)
        view.addSubview(recentlyTitle)
        view.addSubview(recentlyCollection)
    }
    
    func setupLayout() {
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
        
        notFoundView.centerWithSuperview(size: .init(width: self.view.bounds.width, height: 100))
        notFoundView.alpha = 0
    }
    
}
