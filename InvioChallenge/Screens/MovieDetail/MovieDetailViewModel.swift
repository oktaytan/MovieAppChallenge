//
//  MovieDetailViewModel.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import UIKit

/*
 * Detay ekranına ait View Model
 */
class MovieDetailViewModel: NSObject {
    
    var movieID: String?
    
    private(set) var posterCellInfo: PosterCellInfo?
    
    // Loading'in durumunu servisten gelen cevaba göre view'e gönderecek
    var updateIsLoading: (() -> ())?
    
    // Servisten film datası geldiğinde collectionView'i reload edecek
    var reloadTableViewClosure: (() -> ())?
    
    // Servisten hata dönmesi durumunda view'da hata yazısı göstermesini için view'e haber verecek
    var updateHasError: ((CustomError) -> ())?
    
    private(set) var isLoading: Bool = false {
        didSet {
            self.updateIsLoading?()
        }
    }
    
    private(set) var hasError: CustomError? {
        didSet {
            guard let error = hasError else { return }
            self.updateHasError?(error)
        }
    }
    
    private(set) var movieDetail: MovieDetail? {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    init(_ id: String) {
        self.movieID = id
        super.init()
    }
    
    // Filmin detaylarını servisten getiriyor
    func fetchMovieDetail(id: String) {
        self.isLoading = true
        
        app.service.fetchMovieDetail(for: id) { [weak self] (data, error) in
            guard let self = self else { return }
            
            if let error = error {
                self.hasError = CustomError(description: error.localizedDescription)
            }
            guard let detail = data else { return }
            
            self.fetchMoviePoster(urlString: detail.poster) { image in
                self.posterCellInfo = PosterCellInfo(duration: detail.runtime, release: detail.year, language: detail.language, rate: detail.imdbRating, posterImage: image)
                self.isLoading = false
                self.movieDetail = detail
            }
        }
    }
    
    // Filmin posterini servisten getiriyor
    func fetchMoviePoster(urlString: String, completion: @escaping (UIImage) -> Void) {
        app.service.fetchMoviePoster(urlString: urlString) { image, error in
            if let _ = error {
                if let noPoster = UIImage(named: "no_photo") {
                    completion(noPoster)
                }
            }
            guard let poster = image else { return }
            completion(poster)
        }
    }
    
}

