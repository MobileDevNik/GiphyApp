//
//  UIImageView+Extension.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation
import UIKit
enum ImageSource {
    case home
}

extension UIImageView {
    func addBorderCornerRadius(source: ImageSource) {
        switch source {
        case .home:
            layer.cornerRadius = 16.0
            layer.borderWidth = 2.0
            layer.borderColor = UIColor.white.cgColor
            layer.masksToBounds = true
            clipsToBounds = true
        }
    }
}
