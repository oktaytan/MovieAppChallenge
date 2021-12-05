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
        notFoundView.centerWithSuperview(size: .init(width: view.frame.width - 48, height: 80))
        notFoundView.isHidden = true
        
        loadingView.centerWithSuperview()
        loadingView.isHidden = true
    }
    
    func fetchData() {
        loadingView.isLoading = self.viewModel.isLoading
        viewModel.updateIsLoading = { [weak self] in
            guard let self = self else { return }
            self.loadingView.isLoading = self.viewModel.isLoading
        }
        
        viewModel.updateHasError = { [weak self] error in
            guard let self = self else { return }
            self.notFoundView.isHidden = false
            self.collectionView.subviews.forEach { item in
                guard let cell = item as? MovieListCell else { return }
                cell.isHidden = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.notFoundView.isHidden = true
                self.collectionView.subviews.forEach { item in
                    guard let cell = item as? MovieListCell else { return }
                    cell.isHidden = false
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
            self.collectionView.subviews.forEach { item in
                guard let cell = item as? MovieListCell else { return }
                cell.isHidden = false
            }
        }
    }
    
}
