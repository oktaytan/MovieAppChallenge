//
//  MovieListViewModel.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import Foundation

struct MovieListViewModel {
    private let service: NetworkService
    private var searchedMovies: [Movie] = []
    private var lastSearchedMovies: [Movie] = []
    private var popularMovies: [Movie] = []
}

extension MovieListViewModel {
    init(service: NetworkService) {
        self.service = service
    }
}

extension MovieListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSections(in section: Int) -> Int {
        return self.searchedMovies.count
    }
    
    func movieIDAtIndex(at index: Int) -> String {
        let movie = self.searchedMovies[index]
        return movie.id
    }
    
}
