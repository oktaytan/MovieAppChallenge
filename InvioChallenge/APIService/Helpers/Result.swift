//
//  Result.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 4.12.2021.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}
