//
//  MovieList+SearchBarDelegation.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 5.12.2021.
//

import UIKit

// Film listeleme sayfasında searchbarın işlemleri
extension MovieListViewController: SearchBarActiveDelegation {
    
    // Kullanıcı arama yapmak için search field'e dokunduğunda tüm listeyi gizler.
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
    
    // Arama işlemi bittiğinde tüm listeyi gösterir.
    func searchEnd() {
        collectionView.isScrollEnabled = true
        collectionView.subviews.forEach { item in
            if let cell = item as? MovieListCell {
                cell.isHidden = false
            }
        }
    }
    
    /*
     * Kullanıcı aramak için search butonuna bastığında searchbar'ı eski yerine alır.
     * Servise view modelden arama isteğini gönderir.
     * Gelen sonuça göre ya filmleri listeler ya da "Movie Not Found!" uyarısını verir.
     */
    func searchButtonTap(title: String, listTitle: UILabel) {
        
        self.endingSearch()
        self.notFoundView.isHidden = true
        collectionView.subviews.forEach { item in
            guard let cell = item as? MovieListCell else { return }
            cell.isHidden = true
        }
        
        self.viewModel.fetchMovies(title: title)
        self.fetchData()
        listTitle.text = "Search results"        
    }
    
    // Search işlemi bittiğinde ekran gerekli yerleşimleri yapar.
    @objc func endingSearch() {
        collectionView.subviews.forEach { item in
            if let cell = item as? HeaderListCell {
                cell.closeSearch(cell.searchField)
            }
        }
    }
    
}


