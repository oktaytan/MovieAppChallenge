//
//  MovieList+SearchBarDelegation.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 5.12.2021.
//

import UIKit

extension MovieListViewController: SearchBarActiveDelegation {
    
    func searchBegin() {
        collectionView.isScrollEnabled = false
        notFoundView.isHidden = true
        loadingView.isHidden = true
        collectionView.subviews.forEach { item in
            if let cell = item as? MovieListCell {
                cell.isHidden = true
            }
        }
    }
    
    func searchEnd() {
        collectionView.isScrollEnabled = true
        collectionView.subviews.forEach { item in
            if let cell = item as? MovieListCell {
                cell.isHidden = false
            }
        }
    }
    
    func searchButtonTap(title: String, listTitle: UILabel) {
        
        endingSearch()
        collectionView.subviews.forEach { item in
            guard let cell = item as? MovieListCell else { return }
            cell.isHidden = true
        }
        
        self.viewModel.fetchMovies(title: title)
        self.viewModel.updateFetchStatus = {
            self.loadingView.isLoading = self.viewModel.isLoading
            if let error = self.viewModel.hasError?.description {
                DispatchQueue.main.async {
                    self.notFoundView.isHidden = false
                    self.notFoundView.notFoundText.text = error.description
                    print(error)
                    self.collectionView.subviews.forEach { item in
                        guard let cell = item as? MovieListCell else { return }
                        cell.isHidden = false
                    }
                    self.collectionView.reloadData()
                }
            }

            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
            self.collectionView.subviews.forEach { item in
                guard let cell = item as? MovieListCell else { return }
                cell.isHidden = false
            }
        }
    }
    
    @objc func endingSearch() {
        collectionView.subviews.forEach { item in
            if let cell = item as? HeaderListCell {
                cell.closeSearch(cell.searchField)
            }
        }
    }
    
}


