//
//  MovieDetailBuilder.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import UIKit

/*
 * MovieDetailBuilder - Film detay ekranını yaratacak
 * Detayı gösterilecek filmin bilgilerini servisten alabilmek için filmin id'sini set edecek ve
 * ViewModel nesnesine gönderecek
 */
final class MovieDetailBuilder {
    
    static func make(with id: String) -> MovieDetailViewController {
        let layout = UICollectionViewFlowLayout()
        let viewController = MovieDetailViewController(collectionViewLayout: layout)
        viewController.viewModel = MovieDetailViewModel(id)
        return viewController
    }
    
}
