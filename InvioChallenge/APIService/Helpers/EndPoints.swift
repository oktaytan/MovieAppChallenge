//
//  EndPoints.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import Foundation

enum EndPoints {
    case Search
}

// API URL için endpoint ayarlama
extension EndPoints {
    var path: String {
        let baseURL = "http://www.omdbapi.com"
        
        struct Section {
            static let search = "/?"
        }
        
        switch(self) {
        case .Search:
            return "\(baseURL)\(Section.search)"
        }
        
    }
    
}
