//
//  TopNavigationView.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 2.12.2021.
//

import UIKit

final class TopNavigationView: UIView {
    
    init() {
        super.init(frame: .zero)
        setupHierarchy()
        setupLayout()
    }
    
    lazy var menuButton: UIButton = {
        let btn = UIButton(type: .custom)
        let image = UIImage(named: "menuIcon")
        btn.setBackgroundImage(image, for: .normal)
        return btn
    }()
    
    lazy var userPhoto: UIButton = {
        let btn = UIButton(type: .custom)
        let image = UIImage(named: "userPhoto")
        btn.setBackgroundImage(image, for: .normal)
        btn.layer.cornerRadius = 16
        btn.clipsToBounds = true
        btn.contentMode = .scaleAspectFit
        return btn
    }()
    
    fileprivate func setupHierarchy() {
        addSubview(menuButton)
        addSubview(userPhoto)
    }
    
    fileprivate func setupLayout() {
        menuButton.constraintWidth(22)
        menuButton.constraintHeight(22)
        menuButton.centerYSuperView()
        menuButton.anchor(top: nil, bottom: nil, leading: self.leadingAnchor, trailing: nil)
        
        userPhoto.constraintWidth(45)
        userPhoto.constraintHeight(45)
        userPhoto.centerYSuperView()
        userPhoto.anchor(top: nil, bottom: nil, leading: nil, trailing: self.trailingAnchor)
        
        self.constraintHeight(45)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
