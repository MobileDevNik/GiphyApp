//
//  GAListingViewCell.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation
import UIKit
import SDWebImage

class GAListingViewCell: UITableViewCell, TableViewCellProtocol {
    typealias Element = GIF
    var favouriteImageName: String = "heart.fill"
    var nonFavouriteImageName: String = "heart"

    @IBOutlet weak var cellImage: SDAnimatedImageView! {
        didSet {
            cellImage.addBorderCornerRadius(source: .home)
        }
    }
    @IBOutlet weak var favourite: UIButton!
    @IBAction func makeFavourite(_ sender: Any) {
        isFavourite = !isFavourite
        favourite.setImage(isFavourite ? UIImage(systemName: favouriteImageName) : UIImage(systemName: nonFavouriteImageName), for: .normal)
        if !isFavourite {
            guard let id = self.gif?.id else { return }
            GAFavouriteStorage.remove(id: id)
        } else {
            guard let id = self.gif?.id else { return }
            guard let image = self.cellImage.image, image != UIImage.loadingAnimator else { return }
            GAFavouriteStorage.add(image: image, id: id)
        }
    }
    
    var imageLoader: GAImageLoader = GAImageLoader()
    
    var isFavourite: Bool = false
    var gif: GIF?
    
    func setup(with model: GIF) {
        clearForReusability()
        isFavourite = false
        self.gif = model
        
        loadImage()
        checkFavourite()
    }
    
    func clearForReusability() {
        isFavourite = false
        favourite.isHidden = true
        self.gif = nil
        cellImage.image = UIImage.loadingAnimator
    }
    
    func loadImage() {
        guard let url = self.gif?.getUrl() else { return }
        imageLoader.applyGif(usingURL: url, imageView: cellImage, temporaryImage: UIImage.loadingAnimator) {[weak self] in
            if let image = self?.cellImage.image, image != UIImage.loadingAnimator {
                self?.favourite.isHidden = false
            }
        }
    }
    
    func checkFavourite() {
        guard let id = self.gif?.id else { return}
        isFavourite = GAFavouriteStorage.isFavourite(id: id)
        favourite.setImage(isFavourite ? UIImage(systemName: favouriteImageName) : UIImage(systemName: nonFavouriteImageName), for: .normal)
    }
}
