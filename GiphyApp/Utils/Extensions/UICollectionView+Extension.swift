//
//  UICollectionView+Extension.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation
import UIKit
extension UICollectionView {
    func dequeue<T: UICollectionViewCell>(cellClass: T.Type = T.self, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: cellClass.reuseIdentifier, for: indexPath
        ) as? T else {
            fatalError(
                "Error: cell with id: \(cellClass.reuseIdentifier) for indexPath: \(indexPath) is not \(T.self)")
        }
        return cell
    }

    public func register<T: UICollectionViewCell>(cellClass: T.Type) {
        let nib = UINib(nibName: String(describing: cellClass), bundle: nil)
        register(nib, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }
}

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

