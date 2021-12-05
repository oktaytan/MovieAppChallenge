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
        
        loadingView.isHidden = false
        loadingView.isLoading = true
        
        viewModel.fetchMovies(title: title) { [weak self] (search, error) in
            guard let self = self else { return }
            
            if let error = error {
                self.loadingView.isLoading = false
                self.loadingView.isHidden = true
                listTitle.text = "Total results : 0"
                listTitle.isHidden = false
                self.notFoundView.isHidden = false
                self.notFoundView.notFoundText.text = error.description
            } else {
                guard let data = search, let results = data.results else { return }
                self.movies = results
                self.loadingView.isLoading = false
                self.loadingView.isHidden = true
                listTitle.text = "Search results"
                listTitle.isHidden = false
                self.collectionView.subviews.forEach { item in
                    guard let cell = item as? MovieListCell else { return }
                    cell.isHidden = false
                }
                self.collectionView.reloadData()
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


