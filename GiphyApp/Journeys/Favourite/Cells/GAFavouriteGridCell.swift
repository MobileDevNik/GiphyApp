//
//  GAFavouriteGridCell.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//
import Foundation
import UIKit
import SDWebImage

class GAFavouriteGridCell: UICollectionViewCell, CollectionViewCellProtocol {
   
    typealias Element = FavouriteModel
    
    @IBOutlet weak var favouriteImageView: SDAnimatedImageView!{
        didSet {
            favouriteImageView.addBorderCornerRadius(source: .home)
        }
    }
    
    func setup(with model: FavouriteModel) {
        favouriteImageView.image = UIImage.loadingAnimator
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {[weak self] in
                guard let image = GAFavouriteStorage.getImage(forId: model.id) else {return}
                self?.favouriteImageView.image = image
            }
        }
    }
}
