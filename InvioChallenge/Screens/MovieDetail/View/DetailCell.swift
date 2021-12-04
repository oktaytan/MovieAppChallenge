//
//  DetailCell.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 4.12.2021.
//

import UIKit

final class DetailCell: BaseCell {
    
    static let id = "MovieDetailCell"
    
    lazy var detailTitle: UILabel = {
        let label = UILabel()
        label.text = "Director"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .subTextColor
        return label
    }()
    
    lazy var detailInfo: UILabel = {
        let label = UILabel()
        label.text = "Lana Wachowski, Lilly Wachowski"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .textColor
        return label
    }()
    
    override func setupViews() {
        addSubview(detailTitle)
        addSubview(detailInfo)
        
        detailTitle.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 0, right: 24))
        detailTitle.constraintHeight(14)
        detailInfo.anchor(top: detailTitle.bottomAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 0, right: 24))
    }
    
}
