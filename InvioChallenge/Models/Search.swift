//
//  Movie.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import Foundation
    
// Search Model
struct Search: Codable {
    let results: [Movie]?
    let totalResults: String?
    let response: String
    let error: String?
    
    private enum CodingKeys: String, CodingKey {
        case results = "Search"
        case totalResults
        case response = "Response"
        case error = "Error"
    }
    
    struct Movie: Codable {
        let title: String
        let year: String
        let imdbID: String
        let type: String
        let poster: String
  
        private enum CodingKeys: String, CodingKey {
            case title = "Title"
            case year = "Year"
            case imdbID
            case type = "Type"
            case poster = "Poster"
        }
        
    }
}

