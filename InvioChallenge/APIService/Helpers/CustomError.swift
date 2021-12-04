//
//  CustomError.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 4.12.2021.
//

import Foundation

protocol OurErrorProtocol: LocalizedError {
    var description: String { get }
}

struct CustomError: OurErrorProtocol {
    var description: String

    init(description: String) {
        self.description = description
    }
}
