//
//  MovieListViewModel.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import UIKit

class MovieListViewModel: NSObject {
    private var service: NetworkService!
    private var userDefaults = UserDefaults.standard
    
    init(service: NetworkService) {
        super.init()
        self.service = service
    }
    
    func fetchMovies(title: String, completion: @escaping (Search?, CustomError?) -> Void) {
        app.service.fetchMovies(for: title) { [weak self] search in
            guard let self = self else { return }
            switch search {
            case .success(let response):
                if let _ = response.results  {
                    self.userDefaults.set(title, forKey: app.userDefaultsKey)
                    completion(response, nil)
                } else {
                    guard let error = response.error else { return }
                    completion(nil, CustomError(description: error))
                }
            case .failure(let error):
                completion(nil, CustomError(description: error.localizedDescription))
            }
        }
    }
    
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

extension MovieListViewModel {
//    var numberOfSections: Int {
//        return 1
//    }
//
//    func numberOfRowsInSections(in section: Int) -> Int {
//        return self.searchedMovies.count
//    }
//
//    func movieIDAtIndex(at index: Int) -> String {
//        let movie = self.searchedMovies[index]
//        return movie.id
//    }
}


