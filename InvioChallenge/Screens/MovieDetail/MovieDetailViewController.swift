//
//  MovieDetailViewController.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    var movieDetail: MovieDetail? {
        didSet {
            guard let detail = movieDetail else { return }
        }
    }
    
    var viewModel: MovieDetailViewModel? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        
        view.backgroundColor = .red
        
    }
    
}
