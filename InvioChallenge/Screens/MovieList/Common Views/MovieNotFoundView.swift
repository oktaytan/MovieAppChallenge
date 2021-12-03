//
//  MovieNotFoundView.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 2.12.2021.
//

import UIKit

final class MovieNotFoundView: UIView {
    
    init() {
        super.init(frame: .zero)
        setupHierarchy()
        setupLayout()
    }
    
    lazy var notSymbol: UIImageView = {
        let largeFont = UIFont.systemFont(ofSize: 40)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "info.circle", withConfiguration: configuration)
        let view = UIImageView(image: image)
        view.tintColor = .errorColor
        return view
    }()
    
    lazy var notFoundText: UILabel = {
        let label = UILabel()
        label.text = "Movie Not Found!"
        label.font = .preferredFont(forTextStyle: .callout)
        label.textColor = .errorColor
        label.textAlignment = .center
        return label
    }()
    
    fileprivate func setupHierarchy() {
        addSubview(notSymbol)
        addSubview(notFoundText)
    }
    
    fileprivate func setupLayout() {
        notSymbol.anchor(top: topAnchor, bottom: nil, leading: nil, trailing: nil)
        notSymbol.centerXSuperView()
        
        notFoundText.anchor(top: notSymbol.bottomAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        notFoundText.centerXSuperView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
