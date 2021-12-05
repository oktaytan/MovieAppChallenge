//
//  MovieDetailView+DataSetup.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 5.12.2021.
//

import UIKit

extension MovieDetailViewController {
    
    func fetchData() {
        loadingView.isLoading = self.viewModel.isLoading
        self.loadingView.isHidden = !self.viewModel.isLoading
        self.collectionView.isHidden = self.viewModel.isLoading
    
        viewModel.updateIsLoading = { [weak self] in
            guard let self = self else { return }
            self.loadingView.isLoading = self.viewModel.isLoading
            self.loadingView.isHidden = !self.viewModel.isLoading
            self.collectionView.isHidden = self.viewModel.isLoading
            self.navigationItem.setHidesBackButton(self.viewModel.isLoading, animated: true)
        }
        
        viewModel.updateHasError = { [weak self] error in
            guard let self = self else { return }
            self.notFound()
        }
        
        viewModel.reloadTableViewClosure = { [weak self] in
            guard let self = self else { return }
            self.movieFound()
        }
    }
    
    fileprivate func notFound() {
        self.loadingView.isLoading = false
        self.collectionView.isHidden = true
        self.loadingView.isHidden = true
        self.notFoundView.isHidden = false
        self.navigationItem.setHidesBackButton(false, animated: true)
        self.navigationItem.title = "Not Found"
    }
    
    fileprivate func movieFound() {
        self.loadingView.isLoading = false
        self.loadingView.isHidden = true
        self.notFoundView.isHidden = true
        self.collectionView.reloadData()
        self.collectionView.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.collectionView.reloadData()
    }
    
}
