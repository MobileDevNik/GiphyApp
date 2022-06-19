//
//  GAHomeViewController.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import UIKit

enum GAHomeViewControllerEvent {
    case viewLoaded
    case viewAppear
    case userSearching(query: String)
    case loadMoreData
    case userSearchEnd
    case userSelectedGIF
}

class GAHomeViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchHandler.setSearchView(searchBar: searchBar)
            searchHandler.setEventHandler(eventHandler: self)
        }
    }
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            listHandler.setTableView(tableView: tableView)
            listHandler.setEventHandler(eventHandler: self)
        }
    }
    
    let searchHandler: GASearchViewCommunicationProtocol = GASearchView()
    let listHandler: GAListingView<GAListingViewCell> = GAListingView<GAListingViewCell>()
    let viewModel: GAHomeViewModelProtocol = GAHomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setEventHandler(eventHandler: self)
        viewModel.processEvent(viewEvent: .viewLoaded)
    }
}

extension GAHomeViewController: GASearchViewProtocol {
    func searchEvent(event: GASearchBarEvent) {
        view.endEditing(true)
        switch event {
        case .searching(let query):
            viewModel.processEvent(viewEvent: .userSearching(query: query))
        case .searchEnd:
            viewModel.processEvent(viewEvent: .userSearchEnd)
        }
    }
}

extension GAHomeViewController: GAListingViewProtocol {
    func loadMoreItems() {
        viewModel.processEvent(viewEvent: .loadMoreData)
    }
    
    func selectItem() {
        viewModel.processEvent(viewEvent: .userSelectedGIF)
    }
}

extension GAHomeViewController: GAHomeViewModelEventsProtocol {
    func viewModelEvent(event: GAHomeViewModelEvent) {
        switch event {
        case .dataSource(let dataSource):
            listHandler.setDataSource(dataSource: dataSource)
        case .searchFailure:
            print("failure")
        case .trendingFailure:
            print("failure")
        case .dataFetchStarted:
            GAFullLoader.spin(onView: self.view)
        case .dataFetchStopped:
            GAFullLoader.stop()
        }
    }
}
