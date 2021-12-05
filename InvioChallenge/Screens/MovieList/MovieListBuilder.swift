//
//  MovieListBuilder.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import UIKit

/*
 * MovieListBuilder - Listeleme ekranını yaratacak
 * ViewModel nesnesini pass edecek
 */
final class MovieListBuilder {
    
    static func make() -> MovieListViewController {
        let layout = UICollectionViewFlowLayout()
        let viewController = MovieListViewController(collectionViewLayout: layout)
        viewController.viewModel = MovieListViewModel(service: app.service)
        return viewController
    }
    
}
