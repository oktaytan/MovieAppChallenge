//
//  MovieList+Setup.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 5.12.2021.
//

import UIKit

extension MovieListViewController {
    
    func setupView() {
        view.backgroundColor = .white
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceVertical = true
        
        // Searchbar'a dokunulduğunda yeri değiştiğnden geri listeleme görünümüne döner.
        // Ekranı aşağı doğru sürükleyerek görünümleri eski haline getirir.
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(endingSearch))
        swipeGesture.direction = .down
        swipeGesture.numberOfTouchesRequired = 1
        collectionView.addGestureRecognizer(swipeGesture)
        
        // CollectionView için cell register
        collectionView.register(HeaderListCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderListCell.id)
        collectionView.register(MovieListCell.self, forCellWithReuseIdentifier: MovieListCell.id)
    }
    
    func setupHierarchy() {
        collectionView.addSubview(notFoundView)
        collectionView.addSubview(loadingView)
    }
    
    func setupLayout() {
        notFoundView.centerWithSuperview(size: .init(width: view.frame.width - 48, height: 80))
        notFoundView.isHidden = true
        
        loadingView.centerWithSuperview()
        loadingView.isHidden = true
    }
    
    // ViewModel' dan gelen dataya göre kullanıcıya gösterilecek görünümleri ayarlar
    func fetchData() {
        loadingView.isLoading = self.viewModel.isLoading
        
        // Loading görünümü güncelleme
        viewModel.updateIsLoading = { [weak self] in
            guard let self = self else { return }
            self.loadingView.isLoading = self.viewModel.isLoading
        }
        
        // Film bulunamadığında hata döndüğünde gerekli aksiyonlar
        viewModel.updateHasError = { [weak self] error in
            guard let self = self else { return }
            self.notFoundView.isHidden = false
            self.collectionView.subviews.forEach { item in
                guard let cell = item as? MovieListCell else { return }
                cell.isHidden = true
            }
        }

        // Servisten data geldiğinde ekranı güncelleme
        viewModel.reloadTableViewClosure = { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
            self.collectionView.subviews.forEach { item in
                guard let cell = item as? MovieListCell else { return }
                cell.isHidden = false
            }
        }
    }
    
}
