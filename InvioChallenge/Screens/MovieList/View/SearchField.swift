//
//  SearchField.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 2.12.2021.
//

import UIKit

final class SearchField: UISearchBar  {
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    fileprivate func setupView() {
        self.backgroundColor = .bgColor
        self.placeholder = "Type a title"
        self.tintColor = .primaryColor
        self.searchTextField.backgroundColor = .bgColor
        self.searchBarStyle = .minimal
        self.backgroundColor = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
