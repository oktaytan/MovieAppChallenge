//
//  MovieList+Setup.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 5.12.2021.
//

import UIKit

extension MovieListViewController {
    
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
    
    func fetchData() {
        loadingView.isLoading = self.viewModel.isLoading
        viewModel.updateFetchStatus = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.loadingView.isLoading = self.viewModel.isLoading
            }
        }
    }
    
}
