//
//  MovieDetailViewModel.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import UIKit

class MovieDetailViewModel: NSObject {
    var movieID: String?
    private var poster: UIImage?
    
    init(_ id: String) {
        self.movieID = id
        super.init()
    }
    
    func fetchMovieDetail(movieID id: String, completion: @escaping (MovieDetail?, Error?) -> Void) {
        app.service.fetchMovieDetail(for: id) { (data, error) in
            if let error = error {
                completion(nil, error)
            }
            guard let detail = data else { return }
            completion(detail, nil)
        }
    }
    
//    func setMoviePoster() {
//        guard let detail = self.detail else { return }
//        let posterURLString = detail.poster
//
//        app.service.fetchMoviePoster(urlString: posterURLString) { [weak self] image, error in
//            if let error = error {
//                print(error.localizedDescription)
//            }
//
//            guard let poster = image else { return }
//            self?.poster = poster
//        }
//    }
}

