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
        collectionView.isHidden = true
        loadingView.isHidden = false
        loadingView.isLoading = true
        self.navigationItem.setHidesBackButton(false, animated: true)
        
        app.service.fetchMovieDetail(for: movieID) { data, error in
            if let _ = error {
                self.notFound()
                return
            }
            
            guard let detail = data else {
                self.notFound()
                return
            }
            
            self.movieDetail = detail
            self.movieFound()
    
            app.service.fetchMoviePoster(urlString: detail.poster) { data, error in
                if let image = data {
                    DispatchQueue.main.async {
                        self.moviePosterInfo = PosterCellInfo(duration: detail.runtime, release: detail.year, language: detail.language, rate: detail.imdbRating, posterImage: image)
                        self.collectionView.reloadData()
                    }
                }
            }
            
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func notFound() {
        self.loadingView.isLoading = false
        self.loadingView.isHidden = true
        self.movieNotFound.isHidden = false
        self.navigationItem.setHidesBackButton(false, animated: true)
        self.navigationItem.title = "Not Found"
    }
    
    fileprivate func movieFound() {
        self.loadingView.isLoading = false
        self.loadingView.isHidden = true
        self.movieNotFound.isHidden = true
        self.collectionView.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
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
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.item {
        case 0:
            return .init(width: view.frame.width, height: 300)
        case 1:
            if self.movieDetail?.plot == "N/A" {
                return .zero
            }
            return .init(width: view.frame.width, height: 150)
        default:
            return .init(width: view.frame.width, height: 50)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderDetailCell.id, for: indexPath) as? HeaderDetailCell else { return UICollectionReusableView() }
            
            if let detail = self.movieDetail {
                if detail.title.count > 24 {
                    let subMovieTitle = detail.title.prefix(24)
                    header.movieTitle.text = "\(subMovieTitle).."
                } else {
                    header.movieTitle.text = detail.title
                }
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
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SynopsisCell.id, for:  indexPath) as? SynopsisCell else { return UICollectionViewCell() }
            if let detail = self.movieDetail {
                cell.summary = detail.plot
                let height = detail.plot.estimatedHeightForText(view: cell, fontSize: 15) + 50
                cell.frame.size.height = height
            }
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.id, for: indexPath) as? DetailCell else { return UICollectionViewCell() }
            if let detail = self.movieDetail {
                let info = ["Director" : detail.director]
                cell.detailInfo = info
            }
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.id, for: indexPath) as? DetailCell else { return UICollectionViewCell() }
            if let detail = self.movieDetail {
                let info = ["Writer" : detail.writer]
                cell.detailInfo = info
            }
            return cell
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.id, for: indexPath) as? DetailCell else { return UICollectionViewCell() }
            if let detail = self.movieDetail {
                let info = ["Actors" : detail.actors]
                let height = detail.actors.estimatedHeightForText(view: cell, fontSize: 15)
                cell.frame.size.height = height + 10
                cell.detailInfo = info
            }
            return cell
        case 5:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.id, for: indexPath) as? DetailCell else { return UICollectionViewCell() }
            if let detail = self.movieDetail {
                let info = ["Genre" : detail.genre]
                cell.detailInfo = info
            }
            return cell
        case 6:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.id, for: indexPath) as? DetailCell else { return UICollectionViewCell() }
            if let detail = self.movieDetail {
                let info = ["Country" : detail.country]
                cell.detailInfo = info
            }
            return cell
        case 7:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.id, for: indexPath) as? DetailCell else { return UICollectionViewCell() }
            if let detail = self.movieDetail {
                let info = ["Awards" : detail.awards]
                cell.detailInfo = info
            }
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.id, for: indexPath) as? DetailCell else { return UICollectionViewCell() }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 45)
    }
    
}
