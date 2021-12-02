//
//  MovieDetailBuilder.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import Foundation

final class MovieDetailBuilder {
    
    static func make(with id: String) -> MovieDetailViewController {
        let viewController = MovieDetailViewController()
        viewController.viewModel = MovieDetailViewModel(id)
        return viewController
    }
    
}
