//
//  HeaderListCell.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 4.12.2021.
//

import UIKit

final class HeaderListCell: BaseCell {
    
    static let id = "HeaderListCell"
    var delegate: SearchBarActiveDelegation?
    var userDefaults = UserDefaults.standard
    
    let topMenu = TopNavigationView()
    let welcomeText = WelcomeText()
    let searchField = SearchField()
    var searchFieldTopAnchor: NSLayoutConstraint?
    
    lazy var listTitle: UILabel = {
        let label = UILabel()
        
        if let _ = userDefaults.value(forKey: app.userDefaultsKey) {
            label.text = "Recently search"
        } else {
            label.text = ""
        }
        
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .textColor
        if let lastSearch = userDefaults.value(forKey: app.userDefaultsKey) as? String {
            label.alpha = 1
        } else {
            label.alpha = 0
        }
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
    
    lazy var searchButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Search", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        btn.backgroundColor = .primaryColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(searchBtnTapped), for: .touchUpInside)
        return btn
    }()
    
    override func setupViews() {
        searchField.delegate = self
        
        addSubview(topMenu)
        addSubview(welcomeText)
        addSubview(searchField)
        addSubview(listTitle)
        addSubview(searchDescription)
        addSubview(searchButton)
        
        topMenu.centerXSuperView()
        topMenu.anchor(top: safeAreaLayoutGuide.topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 0, right: 24))
        topMenu.constraintHeight(45)
        
        welcomeText.anchor(top: topMenu.bottomAnchor, bottom: nil, leading: topMenu.leadingAnchor, trailing: nil, padding: .init(top: 32, left: 0, bottom: 0, right: 0))
        
        searchField.anchor(top: nil, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 14, bottom: 0, right: 14))
        
        searchFieldTopAnchor = searchField.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 11)
        searchFieldTopAnchor?.isActive = true
        
        listTitle.anchor(top: nil, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 24, right: 24))
        
        searchDescription.anchor(top: topAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 60, left: 0, bottom: 0, right: 0))
        searchDescription.centerXSuperView()
        searchDescription.isHidden = true
        searchDescription.alpha = 0
        
        searchButton.centerXAnchor.constraint(equalTo: searchDescription.centerXAnchor).isActive = true
        searchButton.centerYAnchor.constraint(equalTo: searchDescription.centerYAnchor, constant: 30).isActive = true
        searchButton.constraintWidth(100)
        searchButton.constraintHeight(44)
        searchButton.isHidden = true
    }
    
    @objc func searchBtnTapped() {
        guard let searchTitle = searchField.text else { return }
        delegate?.searchButtonTap(title: searchTitle, listTitle: self.listTitle)
    }
    
}



// MARK: - SearchBar Delegation
protocol SearchBarActiveDelegation: AnyObject {
    func searchBegin()
    func searchEnd()
    func searchButtonTap(title: String, listTitle: UILabel)
}

extension HeaderListCell: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        setSearchButtonAnimation(searchText)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        delegate?.searchBegin()
        listTitle.isHidden = true
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: { [self] in
            topMenu.transform = CGAffineTransform(translationX: 0, y: -30)
            topMenu.alpha = 0
            welcomeText.transform = CGAffineTransform(translationX: 0, y: -30)
            welcomeText.alpha = 0
            searchFieldTopAnchor?.isActive = false
            searchFieldTopAnchor = searchField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -20)
            searchFieldTopAnchor?.isActive = true
            layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 0.2) { [self] in
                searchDescription.isHidden = false
                searchDescription.alpha = 1
                layoutIfNeeded()
            }
        }

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
        listTitle.text = "Recently search"
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: { [self] in
            searchFieldTopAnchor?.isActive = false
            searchFieldTopAnchor = searchField.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 11)
            searchFieldTopAnchor?.isActive = true
            searchDescription.alpha = 0
            searchDescription.isHidden = true
            searchDescription.transform = .identity
            searchButton.transform = .identity
            searchButton.alpha = 0
            searchButton.isHidden = true
            layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseInOut, animations: { [self] in
                topMenu.transform = .identity
                topMenu.alpha = 1
                welcomeText.transform = .identity
                welcomeText.alpha = 1
                listTitle.isHidden = false
                listTitle.alpha = 1
            }, completion: nil)
        }
    }
    
    func setSearchButtonAnimation(_ text: String) {
        if text.count > 0 {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) { [weak self] in
                self?.searchButton.isHidden = false
                self?.searchDescription.transform = CGAffineTransform(translationX: 0, y: -30)
                self?.searchDescription.alpha = 0
                self?.searchButton.alpha = 1
                self?.searchButton.transform = CGAffineTransform(translationX: 0, y: -30)
            } completion: { [weak self] _ in
                self?.searchDescription.isHidden = true
            }
        } else {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) { [weak self] in
                self?.searchDescription.isHidden = false
                self?.searchButton.transform = .identity
                self?.searchButton.alpha = 0
                self?.searchDescription.alpha = 1
                self?.searchDescription.transform = .identity
            } completion: { [weak self] _ in
                self?.searchButton.isHidden = false
            }
        }
    }
    
    
}
