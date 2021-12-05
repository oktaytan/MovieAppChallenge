//
//  MovieListViewModel.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import UIKit

class MovieListViewModel {
    private var service: NetworkService!
    private var userDefaults = UserDefaults.standard
    
    private(set) var movies: [Movie] = []
    var updateFetchStatus: (() -> ())?
    private(set) var hasError: CustomError?
    
    private(set) var isLoading: Bool = false {
        didSet {
            self.updateFetchStatus?()
        }
    }
    
    init(service: NetworkService) {
        self.service = service
        if let title = userDefaults.value(forKey: app.userDefaultsKey) as? String {
            self.fetchMovies(title: title)
        }
    }
    
//    func fetchMovies(title: String, completion: @escaping (Search?, CustomError?) -> Void) {
//        app.service.fetchMovies(for: title) { [weak self] search in
//            guard let self = self else { return }
//            switch search {
//            case .success(let response):
//                if let _ = response.results  {
//                    self.userDefaults.set(title, forKey: app.userDefaultsKey)
//                    completion(response, nil)
//                } else {
//                    guard let error = response.error else { return }
//                    completion(nil, CustomError(description: error))
//                }
//            case .failure(let error):
//                completion(nil, CustomError(description: error.localizedDescription))
//            }
//        }
//    }
    
    func fetchMovies(title: String) {
        self.isLoading = true
        app.service.fetchMovies(for: title) { [weak self] search in
            guard let self = self else { return }
            
            self.isLoading = false
            
            switch search {
            case .success(let response):
                if let movies = response.results  {
                    if movies.count > 0 {
                        self.userDefaults.set(title, forKey: app.userDefaultsKey)
                        self.movies = movies
                    }
                } else {
                    if let error = response.error {
                        self.hasError = CustomError(description: error)
                    }
                }
            case .failure(let error):
                self.hasError = CustomError(description: error.localizedDescription)
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
    var numberOfSections: Int {
        return 1
    }

    func numberOfRowsInSections(in section: Int) -> Int {
        return self.movies.count
    }

    func movieIDAtIndex(at index: Int) -> String {
        let movie = self.movies[index]
        return movie.id
    }
    
    func getMovie(at index: Int) -> Movie {
        return self.movies[index]
    }
}


