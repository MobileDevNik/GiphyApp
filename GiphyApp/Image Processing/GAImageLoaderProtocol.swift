//
//  GAImageLoaderProtocol.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation
import UIKit

public protocol GAImageLoaderProtocol {
    func applyGif(usingURL url: URL, imageView: UIImageView,  temporaryImage: UIImage?, completion: @escaping ()->())
}
