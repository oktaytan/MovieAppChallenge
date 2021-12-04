//
//  MovieListViewModel.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import Foundation

class MovieListViewModel: NSObject {
    private var service: NetworkService!
    private(set) var lastSearchedMovies: [Movie] = []
    private(set) var isLoading = false
    
    init(service: NetworkService) {
        self.service = service
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
    
    func fetchMovies(title: String, completion: @escaping (Search?, CustomError?) -> Void) {
        app.service.fetchMovies(for: title) { search in
            switch search {
            case .success(let response):
                if response.results != nil {
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
}


