//
//  MovieDetailBuilder.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import UIKit

final class MovieDetailBuilder {
    
    static func make(with id: String) -> MovieDetailViewController {
        let layout = UICollectionViewFlowLayout()
        let viewController = MovieDetailViewController(collectionViewLayout: layout)
        viewController.viewModel = MovieDetailViewModel(id)
        return viewController
    }
    
}
