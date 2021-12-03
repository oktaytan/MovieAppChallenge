//
//  AppRouter.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import UIKit

final class AppRouter {
    
    var window: UIWindow?
    var navigationController = UINavigationController()
    
    func start(_ windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        let viewController = MovieListBuilder.make()
        navigationController = UINavigationController(rootViewController: viewController)
        guard let window = window else { return }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func goToDetail(_ movieDetail: MovieDetail) {
        let detailViewController = MovieDetailViewController()
        detailViewController.movieDetail = movieDetail
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func goToMovieList() {
        navigationController.popViewController(animated: true)
    }
    
}
