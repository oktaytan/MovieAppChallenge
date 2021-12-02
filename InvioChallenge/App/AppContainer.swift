//
//  AppContainer.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 1.12.2021.
//

import Foundation

let app = AppContainer()

final class AppContainer {
    let router = AppRouter()
    let service = NetworkService.sharedInstance
}
