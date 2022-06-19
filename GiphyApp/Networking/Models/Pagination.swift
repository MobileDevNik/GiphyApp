//
//  Pagination.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation

public struct Pagination: Codable {
  public let offset: Int
  public let count: Int
  public let total_count: Int
}
