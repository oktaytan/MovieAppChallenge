//
//  Movie.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import Foundation
    
// Search Model
struct Search: Decodable {
    
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
    
   
}

