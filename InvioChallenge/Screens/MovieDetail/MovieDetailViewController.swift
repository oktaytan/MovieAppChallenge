//
//  MovieDetailViewController.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    var viewModel: MovieDetailViewModel!
    var movieDetail: MovieDetail?
    let detailTopNavigationView = DetailTopNavigationView()
    let detailView = DetailView()
    let loadingView = LoadingIndicatorView()
    let movieNotFound = MovieNotFoundView()
    var isLoading: Bool = false
    
    override func viewDidLoad() {
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .white
    }
    
    fileprivate func setupHierarchy() {
        view.addSubview(detailTopNavigationView)
        view.addSubview(detailView)
        view.addSubview(loadingView)
        view.addSubview(movieNotFound)
    }
    
    fileprivate func setupLayout() {
        detailTopNavigationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 24, bottom: 0, right: 24))
        detailTopNavigationView.constraintHeight(44)
        
        detailView.anchor(top: detailTopNavigationView.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 42, left: 24, bottom: 0, right: 24))
        
        loadingView.centerWithSuperview(size: .init(width: 200, height: 200))
        movieNotFound.centerWithSuperview(size: .init(width: self.view.bounds.width, height: 100))
        movieNotFound.isHidden = true
    }
}


