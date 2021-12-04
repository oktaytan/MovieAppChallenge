//
//  TopNavigationView.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 2.12.2021.
//

import UIKit

final class TopNavigationView: UIView {
    
    var themeMode : UIUserInterfaceStyle = .light
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    lazy var menuButton: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "modeIcon")
        btn.setBackgroundImage(image, for: .normal)
        btn.tintColor = .primaryColor
        btn.addTarget(self, action: #selector(modeChangeTap), for: .touchUpInside)
        return btn
    }()
    
    lazy var userPhoto: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "userPhoto")
        btn.setBackgroundImage(image, for: .normal)
        btn.layer.cornerRadius = 16
        btn.clipsToBounds = true
        btn.contentMode = .scaleAspectFit
        return btn
    }()
    
    fileprivate func setupView() {
        backgroundColor = .none
    }
    
    fileprivate func setupHierarchy() {
        addSubview(menuButton)
        addSubview(userPhoto)
    }
    
    fileprivate func setupLayout() {
        menuButton.constraintWidth(30)
        menuButton.constraintHeight(30)
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
    
    @objc func modeChangeTap() {
        guard let keyWindow = UIApplication.shared.connectedScenes
                                .filter({$0.activationState == .foregroundActive})
                                .map({$0 as? UIWindowScene})
                                .compactMap({$0})
                                .first?.windows
                                .filter({$0.isKeyWindow}).first else { return }
        
        if self.themeMode == .light {
            keyWindow.overrideUserInterfaceStyle = .dark
            self.themeMode = .dark
        } else {
            keyWindow.overrideUserInterfaceStyle = .light
            self.themeMode = .light
        }
        
    }
}
