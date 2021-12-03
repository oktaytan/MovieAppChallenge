//
//  DetailTopNavigationView.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 3.12.2021.
//

import UIKit

final class DetailTopNavigationView: UIView {
    
    private var isLike: Bool = false
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
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
    
    fileprivate func setupView() {
        backgroundColor = .none
    }
    
    fileprivate func setupHierarchy() {
        self.addSubview(backButton)
        self.addSubview(movieTitle)
        self.addSubview(likeButton)
    }
    
    fileprivate func setupLayout() {
        backButton.anchor(top: nil, bottom: nil, leading: leadingAnchor, trailing: nil)
        backButton.centerYSuperView()
        backButton.constraintWidth(24)
        backButton.constraintHeight(20)
        
        movieTitle.centerWithSuperview()
        
        likeButton.anchor(top: nil, bottom: nil, leading: nil, trailing: trailingAnchor)
        likeButton.centerYSuperView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func like() {
        self.isLike.toggle()
        self.likeButton.tintColor = self.isLike ? .secondaryColor : .bgColor
    }
    
    @objc func goBack() {
        app.router.goToMovieList()
    }
}

