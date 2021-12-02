//
//  MovieList+SearchBarDelegation.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 2.12.2021.
//

import UIKit

extension MovieListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: { [self] in
            topMenu.transform = CGAffineTransform(translationX: 0, y: -30)
            topMenu.alpha = 0
            welcomeText.transform = CGAffineTransform(translationX: 0, y: -30)
            welcomeText.alpha = 0
            searchFieldTopAnchor?.isActive = false
            searchFieldTopAnchor = searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20)
            searchFieldTopAnchor?.isActive = true
            searchDescription.alpha = 1
            recentlyTitle.alpha = 0
            recentlyCollection.alpha = 0
            view.layoutIfNeeded()
        }, completion: nil)

        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.closeSearch(searchBar)
    }
    
    fileprivate func closeSearch(_ searchBar: UISearchBar) {
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
            searchDescription.alpha = 0
            recentlyTitle.alpha = 1
            recentlyCollection.alpha = 1
            view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    @objc func endingSearch() {
        self.closeSearch(searchField)
    }
}
