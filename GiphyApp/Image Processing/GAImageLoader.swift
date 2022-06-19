//
//  GAImageLoader.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation
import UIKit
import SDWebImage

struct GAImageLoader: GAImageLoaderProtocol {
    func applyGif(usingURL url: URL, imageView: UIImageView, temporaryImage: UIImage?, completion: @escaping () -> ()) {
        guard let imageView = imageView as? SDAnimatedImageView else {
          fatalError("Progressive Images cannot be displayed on UIImageView!")
        }
        
        imageView.sd_setImage(with: url, placeholderImage: temporaryImage, options: [.scaleDownLargeImages]) { (_, _, _, _) in
          completion()
        }
    }
}
