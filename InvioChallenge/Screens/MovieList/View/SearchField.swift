//
//  SearchField.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 2.12.2021.
//

import UIKit

// Kullanıcının film araması için searchbar
final class SearchField: UISearchBar  {
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    fileprivate func setupView() {
        self.placeholder = "Search Movie"
        self.tintColor = .primaryColor
        self.searchTextField.backgroundColor = .bgColor
        self.searchBarStyle = .minimal
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
