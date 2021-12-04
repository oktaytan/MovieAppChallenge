//
//  DetailCell.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 4.12.2021.
//

import UIKit

final class DetailCell: BaseCell {
    
    static let id = "MovieDetailCell"
    var detailInfo: [String : String]? {
        didSet {
            guard let info = detailInfo else { return }
            info.forEach { (key: String, value: String) in
                detailTitle.text = key
                detailText.text = value
            }
        }
    }
    
    lazy var detailTitle: UILabel = {
        let label = UILabel()
        label.text = "----"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .subTextColor
        return label
    }()
    
    lazy var detailText: UILabel = {
        let label = UILabel()
        label.text = "----"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .textColor
        label.numberOfLines = 10
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    override func setupViews() {
        addSubview(detailTitle)
        addSubview(detailText)
        
        detailTitle.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 0, right: 24))
        detailTitle.constraintHeight(14)
        detailText.anchor(top: detailTitle.bottomAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 0, right: 24))
    }
    
}
