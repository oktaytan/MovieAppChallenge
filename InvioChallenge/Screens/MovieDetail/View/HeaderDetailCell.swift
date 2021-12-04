//
//  HeaderDetailCell.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 4.12.2021.
//

import UIKit

class HeaderDetailCell: BaseCell {
    
    static let id = "HeaderDetailCell"
    var isLike: Bool = false
    
    lazy var backButton: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "leftArrow")
        btn.setBackgroundImage(image, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return btn
    }()
    
    lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.text = "The Matrix"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .textColor
        return label
    }()
    
    lazy var likeButton: UIButton = {
        let btn = UIButton(type: .system)
        let largeFont = UIFont.systemFont(ofSize: 24)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "star.fill", withConfiguration: configuration)
        btn.setBackgroundImage(image, for: .normal)
        btn.tintColor = self.isLike ? .secondaryColor : .bgColor
        btn.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(like), for: .touchUpInside)
        return btn
    }()
    
    override func setupViews() {

        self.addSubview(backButton)
        self.addSubview(movieTitle)
        self.addSubview(likeButton)
        
        backButton.anchor(top: nil, bottom: nil, leading: leadingAnchor, trailing: nil, padding: .init(top: 0, left: 24, bottom: 0, right: 0))
        backButton.centerYSuperView()
        backButton.constraintWidth(24)
        backButton.constraintHeight(20)
        
        movieTitle.centerWithSuperview()
        
        likeButton.anchor(top: nil, bottom: nil, leading: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 24))
        likeButton.centerYSuperView()
    }
    
    @objc func like() {
        self.isLike.toggle()
        self.likeButton.tintColor = self.isLike ? .secondaryColor : .bgColor
    }
    
    @objc func goBack() {
        app.router.goToMovieList()
    }
    
}
