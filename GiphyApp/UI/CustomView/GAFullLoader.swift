//
//  GAFullLoader.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation
import UIKit

open class GAFullLoader {
    internal static var spinnerView: UIActivityIndicatorView?
    
    public static var style: UIActivityIndicatorView.Style = .large
    public static var backgroundColor: UIColor = UIColor(white: 0, alpha: 0.6)
    
    internal static var touchHandler: (() -> Void)?
    
    public static func spin(onView view: UIView, style: UIActivityIndicatorView.Style = style, backgroundColor: UIColor = backgroundColor, touchHandler: (() -> Void)? = nil) {
        if spinnerView == nil {
            let frame = UIScreen.main.bounds
            spinnerView = UIActivityIndicatorView(frame: frame)
            spinnerView!.backgroundColor = backgroundColor
            spinnerView!.color = .white
            spinnerView!.style = style
            view.addSubview(spinnerView!)
            view.bringSubviewToFront(spinnerView!)
            spinnerView!.startAnimating()
        }
        
        if touchHandler != nil {
            self.touchHandler = touchHandler
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(runTouchHandler))
            spinnerView!.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc internal static func runTouchHandler() {
        if touchHandler != nil {
            touchHandler!()
        }
    }
    
    public static func stop() {
        DispatchQueue.main.async {
            if let _ = spinnerView {
                spinnerView!.stopAnimating()
                spinnerView!.removeFromSuperview()
                spinnerView = nil
            }
        }
    }
}
