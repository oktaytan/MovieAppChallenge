//
//  HeaderCell.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 4.12.2021.
//

import UIKit

final class HeaderCell: BaseCell {
    
    static let id = "HeaderCell"
    var delegate: SearchBarActiveDelegation?
    
    let topMenu = TopNavigationView()
    let welcomeText = WelcomeText()
    let searchField = SearchField()
    var searchFieldTopAnchor: NSLayoutConstraint?
    
    lazy var listTitle: UILabel = {
        let label = UILabel()
        label.text = "Recently Searches"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .textColor
        return label
    }()
    
    lazy var searchDescription: UILabel = {
        let label = UILabel()
        label.text = "Type the name of the movie\n you want to search"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .subTextColor
        return label
    }()
    
    override func setupViews() {
        searchField.delegate = self
        addSubview(topMenu)
        addSubview(welcomeText)
        addSubview(searchField)
        addSubview(listTitle)
        addSubview(searchDescription)
        
        topMenu.centerXSuperView()
        topMenu.anchor(top: safeAreaLayoutGuide.topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 0, right: 24))
        topMenu.constraintHeight(45)
        
        welcomeText.anchor(top: topMenu.bottomAnchor, bottom: nil, leading: topMenu.leadingAnchor, trailing: nil, padding: .init(top: 32, left: 0, bottom: 0, right: 0))
        
        searchField.anchor(top: nil, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 14, bottom: 0, right: 14))
        
        searchFieldTopAnchor = searchField.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 11)
        searchFieldTopAnchor?.isActive = true
        
        listTitle.anchor(top: nil, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 24, right: 24))
        
        searchDescription.anchor(top: searchField.bottomAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 30, left: 0, bottom: 0, right: 0))
        searchDescription.centerXSuperView()
        searchDescription.isHidden = true
        searchDescription.alpha = 0
        
    }
    
}

protocol SearchBarActiveDelegation: AnyObject {
    func searchBegin()
    func searchEnd()
}

extension HeaderCell: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        delegate?.searchBegin()
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: { [self] in
            topMenu.transform = CGAffineTransform(translationX: 0, y: -30)
            topMenu.alpha = 0
            welcomeText.transform = CGAffineTransform(translationX: 0, y: -30)
            welcomeText.alpha = 0
            searchFieldTopAnchor?.isActive = false
            searchFieldTopAnchor = searchField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -20)
            searchFieldTopAnchor?.isActive = true
            listTitle.alpha = 0
            searchDescription.isHidden = false
            searchDescription.alpha = 1
            layoutIfNeeded()
        }, completion: nil)

        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        delegate?.searchEnd()
        self.closeSearch(searchBar)
    }
    
    func closeSearch(_ searchBar: UISearchBar) {
        delegate?.searchEnd()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.searchTextField.resignFirstResponder()
        searchBar.searchTextField.text = ""
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: { [self] in
            topMenu.transform = .identity
            topMenu.alpha = 1
            welcomeText.transform = .identity
            welcomeText.alpha = 1
            searchFieldTopAnchor?.isActive = false
            searchFieldTopAnchor = searchField.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 11)
            searchFieldTopAnchor?.isActive = true
            listTitle.alpha = 1
            searchDescription.alpha = 0
            searchDescription.isHidden = true
            layoutIfNeeded()
        }, completion: nil)
        
    }
    
}
