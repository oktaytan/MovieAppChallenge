//
//  MovieDetailViewController.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import UIKit

final class MovieDetailViewController: UICollectionViewController {
    
    var viewModel: MovieDetailViewModel!
    var movieDetail: MovieDetail?
    let loadingView = LoadingIndicatorView()
    let movieNotFound = MovieNotFoundView()
    var isLoading: Bool = false
    
    let summary = "When a beautiful stranger leads computer hacker Neo to a forbidding underworld, he discovers the shocking trut the life he knows is the elaborate deception of an evil cyber-intelligence."
    
    override func viewDidLoad() {
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .bgColor
        collectionView.register(HeaderDetailCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderDetailCell.id)
        collectionView.register(MoviePosterCell.self, forCellWithReuseIdentifier: MoviePosterCell.id)
        collectionView.register(SynopsisCell.self, forCellWithReuseIdentifier: SynopsisCell.id)
        collectionView.register(BaseCell.self, forCellWithReuseIdentifier: "test")
    }
    
    fileprivate func setupHierarchy() {
        view.addSubview(loadingView)
        view.addSubview(movieNotFound)
    }
    
    fileprivate func setupLayout() {
        loadingView.centerWithSuperview(size: .init(width: 200, height: 200))
        loadingView.isHidden = true
        movieNotFound.centerWithSuperview(size: .init(width: self.view.bounds.width, height: 100))
        movieNotFound.isHidden = true
    }
}


// MARK: - CollectionView Delegation
extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.item {
        case 0:
            return .init(width: view.frame.width, height: 300)
        case 1:
            return .init(width: view.frame.width, height: 180)
        default:
            return .init(width: view.frame.width, height: 60)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderDetailCell.id, for: indexPath) as? HeaderDetailCell else { return UICollectionReusableView() }
            return header
        }
        
        return UICollectionReusableView()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCell.id, for:  indexPath) as? MoviePosterCell else { return UICollectionViewCell() }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SynopsisCell.id, for:  indexPath) as? SynopsisCell else { return UICollectionViewCell() }
            cell.summary = self.summary
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath) as! BaseCell
            cell.backgroundColor = .red
            return cell
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 45)
    }
    
}
