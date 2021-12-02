//
//  UIColor+Extensions.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 2.12.2021.
//

import UIKit

extension UIColor {
    
    static let bgColor: UIColor = UIColor(named: "bgColor") ?? .systemBlue
    static let primaryColor: UIColor = UIColor(named: "primaryColor") ?? .systemGreen
    static let secondaryColor: UIColor = UIColor(named: "secondaryColor") ?? .systemYellow
    static let textColor: UIColor = UIColor(named: "textColor") ?? .black
    static let subTextColor: UIColor = UIColor(named: "subTextColor") ?? .systemGray
    static let landingColor: UIColor = UIColor(named: "landingColor") ?? .black
    static let errorColor: UIColor = UIColor(named: "errorColor") ?? .systemRed
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
