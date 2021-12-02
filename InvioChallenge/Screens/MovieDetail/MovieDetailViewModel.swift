//
//  MovieDetailViewModel.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import Foundation

class MovieDetailViewModel {
    private var detail: MovieDetail?
    
    init(_ id: String) {
        app.service.fetchMovieDetail(for: id) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let detail = data else { return }
            self.detail = detail
        }
    }
}

