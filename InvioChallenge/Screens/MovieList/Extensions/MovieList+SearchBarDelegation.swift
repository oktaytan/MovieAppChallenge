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
        
        self.endingSearch()
        self.notFoundView.isHidden = true
        collectionView.subviews.forEach { item in
            guard let cell = item as? MovieListCell else { return }
            cell.isHidden = true
        }
        
        self.viewModel.fetchMovies(title: title)
        self.fetchData()
        listTitle.text = "Recently search"
    }
    
    @objc func endingSearch() {
        collectionView.subviews.forEach { item in
            if let cell = item as? HeaderListCell {
                cell.closeSearch(cell.searchField)
            }
        }
    }
    
}


