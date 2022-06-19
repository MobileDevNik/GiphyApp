//
//  GAFavouriteTableCell.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation
import UIKit
import SDWebImage


class GAFavouriteTableCell: UITableViewCell, TableViewCellProtocol {
   
    typealias Element = FavouriteModel

    @IBOutlet weak var cellImage: SDAnimatedImageView! {
        didSet {
            cellImage.addBorderCornerRadius(source: .home)
        }
    }
    
    func setup(with model: FavouriteModel) {
        cellImage.image = UIImage.loadingAnimator
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {[weak self] in
                guard let image = GAFavouriteStorage.getImage(forId: model.id) else {return}
                self?.cellImage.image = image
            }
        }
    }
}
