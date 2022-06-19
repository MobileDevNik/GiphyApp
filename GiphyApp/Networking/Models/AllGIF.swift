//
//  AllGIF.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation

public struct AllGIF: Codable {
  public let data: [GIF]
  public let pagination: Pagination
}
