//
//  NetworkService.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import Foundation
import Alamofire
import AlamofireImage

final class NetworkService {
    
    private let apiKey = "4ab16e2b"
    
    private init() { }
    
    static var sharedInstance: NetworkService = {
        return NetworkService()
    }()
    
}


extension NetworkService {
    
    func fetchMovies(for title: String, page: Int = 1, handler: @escaping (Result<Search>) -> Void) {
        
        let paramaters: [String : Any] = [
            "apikey": apiKey,
            "s" : title,
            "type" : "movie",
            "page" : page
        ]
        
        let request = AF.request(EndPoints.Search.path, method: .get, parameters: paramaters)
        
        request.responseDecodable { (response: DataResponse<Search, AFError>) in
            switch response.result {
            case .success(let search):
                handler(.success(search))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
  
    func fetchMovieDetail(for id: String, handler: @escaping (MovieDetail?, Error?) -> Void) {
        
        let paramaters: [String : Any] = [
            "apikey": apiKey,
            "i" : id
        ]
        
        let request = AF.request(EndPoints.Search.path, method: .get, parameters: paramaters)
        
        request.responseDecodable { (response: DataResponse<MovieDetail, AFError>) in
            switch response.result {
            case .success(let movie):
                handler(movie, nil)
            case .failure(let error):
                handler(nil, error)
            }
        }
        
    }
    
    func fetchMoviePoster(urlString: String, handler: @escaping (UIImage?, Error?) -> Void) {
        if urlString != "N/A" {
            AF.request(urlString).responseImage { (response: DataResponse<UIImage, AFError>) in
                switch response.result {
                case .success(let image):
                    handler(image, nil)
                case .failure(let error):
                    handler(nil, error)
                }
            }
        } else {
            handler(nil, CustomError(description: "URL is not valid!"))
        }
        
    }
    

}

