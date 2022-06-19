//
//  GAListingView.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//


import Foundation
import UIKit

protocol TableViewCellProtocol {
    associatedtype Element
    func setup(with model: Element)
}
protocol GAListingViewProtocol: AnyObject {
    func selectItem()
    func loadMoreItems()
}

class GAListingView<T: UITableViewCell>: UIView, UITableViewDelegate, UITableViewDataSource where T: TableViewCellProtocol {
    private weak var eventHandler: GAListingViewProtocol?
    private var dataSource: [T.Element] = [] {
        didSet {
            tableView?.reloadData()
        }
    }
    private weak var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self
            tableView?.register(cellClass: T.self)
            tableView?.allowsMultipleSelectionDuringEditing = false
        }
    }
    
    func setEventHandler(eventHandler: GAListingViewProtocol) {
        self.eventHandler = eventHandler
    }
    
    func setTableView(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func setDataSource(dataSource: [T.Element]) {
        self.dataSource = dataSource
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: T = tableView.dequeue(forIndexPath: indexPath)
        cell.setup(with: dataSource[indexPath.row])
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (dataSource.count - 1) {
            self.eventHandler?.loadMoreItems()
        }
    }
}
