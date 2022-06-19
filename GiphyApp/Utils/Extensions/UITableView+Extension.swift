//
//  UITableView+Extension.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation
import UIKit

public extension UITableView {
    func dequeue<T: UITableViewCell>(cellClass: T.Type = T.self, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withIdentifier: cellClass.reuseIdentifier, for: indexPath
        ) as? T else {
            fatalError(
                "Error: cell with id: \(cellClass.reuseIdentifier) for indexPath: \(indexPath) is not \(T.self)")
        }
        return cell
    }
    
    func register<T: UITableViewCell>(cellClass: T.Type) {
        let nib = UINib(nibName: String(describing: cellClass), bundle: nil)
        register(nib, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }
}
