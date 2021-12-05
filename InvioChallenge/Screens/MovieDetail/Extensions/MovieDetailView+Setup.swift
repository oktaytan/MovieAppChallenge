//
//  MovieDetailView+Setup.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 5.12.2021.
//

import UIKit

extension MovieDetailViewController {
    
    func setupView() {
        view.backgroundColor = .white
        
        // CollectionView'da gösterilecek custom görünümler
        collectionView.register(HeaderDetailCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderDetailCell.id)
        collectionView.register(MoviePosterCell.self, forCellWithReuseIdentifier: MoviePosterCell.id)
        collectionView.register(SynopsisCell.self, forCellWithReuseIdentifier: SynopsisCell.id)
        collectionView.register(DetailCell.self, forCellWithReuseIdentifier: DetailCell.id)
        collectionView.register(BaseCell.self, forCellWithReuseIdentifier: "test")
    }
    
    func setupHierarchy() {
        view.addSubview(loadingView)
        view.addSubview(notFoundView)
    }
    
    func setupLayout() {
        loadingView.centerWithSuperview()
        loadingView.isHidden = true
        
        notFoundView.centerWithSuperview(size: .init(width: self.view.bounds.width, height: 100))
        notFoundView.isHidden = true
    }
    
}
