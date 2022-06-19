//
//  GASegmentView.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation
import UIKit

enum GASegmentEvent: Int {
    case list = 0
    case grid = 1
}

protocol GASegmentViewProtocol: AnyObject {
    func segmentEvent(event: GASegmentEvent)
}

class GASegmentView: UIView {
    weak var eventHandler: GASegmentViewProtocol?
    weak var segmentControl: UISegmentedControl? {
        didSet {
            segmentControl?.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        }
    }
    @objc func segmentAction(_ segmentedControl: UISegmentedControl) {
        guard let event = GASegmentEvent(rawValue: segmentedControl.selectedSegmentIndex) else { return }
        eventHandler?.segmentEvent(event: event)
    }
}
