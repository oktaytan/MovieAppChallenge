//
//  AppRouter.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import UIKit


/*
 * AppRouter - App başladığında ekranlar arasında geçişleri yapacak
 * Geçişler esnasında load olacak ekranın başlarken ihtiyacı olan datayı pass edecek
 */
final class AppRouter {
    
    var window: UIWindow?
    var navigationController = UINavigationController()
    
    // App ilk açıldığında çalışacak root ekran
    func start(_ windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        let viewController = MovieListBuilder.make()
        navigationController = UINavigationController(rootViewController: viewController)
        
        guard let window = window else { return }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    // Film detayına gidecek ve movieID ile o filme ait detayları getirecek
    func goToDetail(_ movieID: String) {
        let detailViewController = MovieDetailBuilder.make(with: movieID)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    // Detay sayfasından listeleme sayfasına dönecek
    func goToMovieList() {
        navigationController.popViewController(animated: true)
    }
    
}
