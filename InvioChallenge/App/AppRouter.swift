//
//  AppRouter.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import UIKit

final class AppRouter {
    
    var window: UIWindow?
    
    func start(_ windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        let viewController = MovieListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        guard let window = window else { return }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func goToDetail() {
        
    }
    
}
