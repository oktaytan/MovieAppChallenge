//
//  MovieDetailViewController.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import UIKit

final class MovieDetailViewController: UICollectionViewController {
    
    var viewModel: MovieDetailViewModel! {
        didSet {
            guard let vm = viewModel else { return }
            if let id = vm.movieID {
                getMovieDetail(movieID: id)
            }
        }
    }
    var movieDetail: MovieDetail?
    let loadingView = LoadingIndicatorView()
    let movieNotFound = MovieNotFoundView()
    var moviePosterInfo: PosterCellInfo?
    var isLoading: Bool = false
    var notFound: Bool = true
    
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
        view.backgroundColor = .white
        collectionView.register(HeaderDetailCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderDetailCell.id)
        collectionView.register(MoviePosterCell.self, forCellWithReuseIdentifier: MoviePosterCell.id)
        collectionView.register(SynopsisCell.self, forCellWithReuseIdentifier: SynopsisCell.id)
        collectionView.register(DetailCell.self, forCellWithReuseIdentifier: DetailCell.id)
        collectionView.register(BaseCell.self, forCellWithReuseIdentifier: "test")
    }
    
    fileprivate func setupHierarchy() {
        view.addSubview(loadingView)
        view.addSubview(movieNotFound)
    }
    
    fileprivate func setupLayout() {
        loadingView.centerWithSuperview()
        loadingView.isHidden = true
        movieNotFound.centerWithSuperview(size: .init(width: self.view.bounds.width, height: 100))
        movieNotFound.isHidden = true
    }
    
    func getMovieDetail(movieID: String) {
        loadingView.isHidden = false
        loadingView.isLoading = true
        
        app.service.fetchMovieDetail(for: movieID) { data, error in
            if let _ = error {
                self.loadingView.isLoading = false
                self.loadingView.isHidden = true
                self.movieNotFound.isHidden = false
                self.notFound = true
                return
            }
            
            guard let detail = data else {
                self.loadingView.isLoading = false
                self.loadingView.isHidden = true
                self.movieNotFound.isHidden = false
                self.notFound = true
                return
            }
            
            app.service.fetchMoviePoster(urlString: detail.poster) { data, error in
                
                if let image = data {
                    DispatchQueue.main.async {
                        self.movieDetail = detail
                        self.loadingView.isLoading = false
                        self.loadingView.isHidden = true
                        self.movieNotFound.isHidden = true
                        self.collectionView.isHidden = false
                        self.collectionView.reloadData()
                        self.moviePosterInfo = PosterCellInfo(duration: detail.runtime, release: detail.year, language: detail.language, rate: detail.imdbRating, posterImage: image)
                        self.notFound = false
                    }
                }
                
            }
            
        }
    }
}


// MARK: - CollectionView Delegation
extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.item {
        case 0:
            return .init(width: view.frame.width, height: 300)
        case 1:
            return .init(width: view.frame.width, height: 180)
        default:
            return .init(width: view.frame.width, height: 50)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderDetailCell.id, for: indexPath) as? HeaderDetailCell else { return UICollectionReusableView() }
            if let detail = self.movieDetail {
                let subMovieTitle = detail.title.prefix(24)
                header.movieTitle.text = "\(subMovieTitle).."
            }
            return header
        }
        
        return UICollectionReusableView()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCell.id, for:  indexPath) as? MoviePosterCell else { return UICollectionViewCell() }
            cell.cellInfo = self.moviePosterInfo
            cell.isHidden = self.notFound
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SynopsisCell.id, for:  indexPath) as? SynopsisCell else { return UICollectionViewCell() }
            if let detail = self.movieDetail {
                cell.summary = detail.plot
            }
            cell.isHidden = self.notFound
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.id, for: indexPath) as? DetailCell else { return UICollectionViewCell() }
            cell.isHidden = self.notFound
            return cell
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 45)
    }
    
}
