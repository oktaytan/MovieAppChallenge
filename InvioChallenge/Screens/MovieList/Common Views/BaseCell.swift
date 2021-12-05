//
//  BaseCell.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 2.12.2021.
//

import UIKit

// Tüm collection cell'lerin miras alacağı base cell
class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
