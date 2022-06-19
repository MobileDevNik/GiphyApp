//
//  GAGridView.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation
import UIKit

protocol CollectionViewCellProtocol {
    associatedtype Element
    func setup(with model: Element)
}

class GAGridView<T: UICollectionViewCell>: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout where T: CollectionViewCellProtocol {
    private weak var eventHandler: GAListingViewProtocol?
    private var dataSource: [T.Element] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    private weak var collectionView: UICollectionView? {
        didSet {
            collectionView?.delegate = self
            collectionView?.dataSource = self
            collectionView?.register(cellClass: T.self)
            collectionView?.allowsMultipleSelectionDuringEditing = false
        }
    }
    
    func setEventHandler(eventHandler: GAListingViewProtocol) {
        self.eventHandler = eventHandler
    }
    
    func setCollectionView(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    func setDataSource(dataSource: [T.Element]) {
        self.dataSource = dataSource
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: T = collectionView.dequeue(forIndexPath: indexPath)
        cell.setup(with: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let requiredWidth = UIScreen.main.bounds.size.width/2 - 15
        return CGSize.init(width: requiredWidth, height: requiredWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
      if indexPath.row == dataSource.count - 1 {
        eventHandler?.loadMoreItems()
      }
    }
}
