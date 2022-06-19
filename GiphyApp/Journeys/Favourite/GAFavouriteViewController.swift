//
//  GAFavouriteViewController.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import UIKit

enum GAFavViewControllerEvent {
    case loadList
    case LoadGrid
    case loadMore
    case viewAppear
}

class GAFavViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl! {
        didSet {
            segmentHandler.segmentControl = segmentControl
            segmentHandler.eventHandler = self
        }
    }
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            listHandler.setTableView(tableView: tableView)
            listHandler.setEventHandler(eventHandler: self)
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet {
            gridHandler.setCollectionView(collectionView: collectionView)
            gridHandler.setEventHandler(eventHandler: self)
        }
    }
    
    let segmentHandler: GASegmentView = GASegmentView()
    let listHandler: GAListingView<GAFavouriteTableCell> = GAListingView<GAFavouriteTableCell>()
    let gridHandler: GAGridView<GAFavouriteGridCell> = GAGridView<GAFavouriteGridCell>()

    let viewModel: GAFavViewModelProtocol = GAFavViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setEventHandler(eventHandler: self)
        collectionView.isHidden = true
        tableView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.processEvent(viewEvent: .viewAppear)
    }
}

extension GAFavViewController: GASegmentViewProtocol {
    func segmentEvent(event: GASegmentEvent) {
        switch event {
        case .list:
            collectionView.isHidden = true
            tableView.isHidden = false
            viewModel.processEvent(viewEvent: .loadList)
        case .grid:
            collectionView.isHidden = false
            tableView.isHidden = true
            viewModel.processEvent(viewEvent: .LoadGrid)
        }
    }
}

extension GAFavViewController: GAListingViewProtocol {
    func loadMoreItems() {
        viewModel.processEvent(viewEvent: .loadMore)
    }
    
    func selectItem() {
    }
}

extension GAFavViewController: GAFavViewModelEventsProtocol {
    func viewModelEvent(event: GAFavViewModelEvent) {
        switch event {
        case .listData(let data):
            listHandler.setDataSource(dataSource: data)
        case .gridData(let data):
            gridHandler.setDataSource(dataSource: data)
        case .dataFetchStarted:
            GAFullLoader.spin(onView: self.view)
        case .dataFetchStopped:
            GAFullLoader.stop()
        }
    }
}
