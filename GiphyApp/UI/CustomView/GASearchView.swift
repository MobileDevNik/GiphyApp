//
//  GASearchView.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation
import UIKit

enum GASearchBarEvent {
    case searching(query: String)
    case searchEnd
}

protocol GASearchViewProtocol: AnyObject {
    func searchEvent(event: GASearchBarEvent)
}

protocol GASearchViewCommunicationProtocol: AnyObject {
    func setSearchView(searchBar: UISearchBar)
    func setEventHandler(eventHandler: GASearchViewProtocol)
}

class GASearchView: UIView {
    weak var eventHandler: GASearchViewProtocol?
    weak var searchBar: UISearchBar? {
        didSet {
            searchBar?.delegate = self
        }
    }
}

extension GASearchView: GASearchViewCommunicationProtocol {
    func setEventHandler(eventHandler: GASearchViewProtocol) {
        self.eventHandler = eventHandler
    }
    
    func setSearchView(searchBar: UISearchBar) {
        self.searchBar = searchBar
        self.searchBar?.searchTextField.clearButtonMode = .never
    }
    func clearSearch() {
        searchBar?.text = ""
        searchBar?.resignFirstResponder()
    }
}

extension GASearchView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            searchBar.resignFirstResponder()
            eventHandler?.searchEvent(event: .searching(query: searchText))
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newString = NSString(string: searchBar.text!).replacingCharacters(in: range, with: text)
        if newString.isEmpty {
            clearSearch()
            eventHandler?.searchEvent(event: .searchEnd)
        }
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            clearSearch()
            eventHandler?.searchEvent(event: .searchEnd)
        }
    }
    
    
}
