//
//  UIImage+Extension.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation
import UIKit
import SDWebImage


extension UIImage {
    public class var loadingAnimator: SDAnimatedImage? {
      get { SDAnimatedImage.init(named: "loader.gif") }
    }
}
