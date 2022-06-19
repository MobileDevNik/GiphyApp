//
//  GAHomeUseCaseURLBuilder.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation

public protocol Request {
  var url: URL? { get }
}

enum GAHomeUseCaseURLBuilder: Request {
  case defaultGIFs(offset: Int, limit: Int)
  case findGIFs(searchQuery: String, offset: Int, limit: Int)
  
  var url: URL? {
    let baseUrl = "https://api.giphy.com/v1/gifs"
    guard  let apiKey = GAConfigurations.apiKey() else {return nil}//"Y5ILUUzf0rYsZe9w3XNKldyRKifgvMJQ"
    switch self {
    case .defaultGIFs(let offset, let limit):
      return URL(string: "\(baseUrl)/trending?api_key=\(apiKey)&offset=\(offset)&limit=\(limit)")
    case .findGIFs(let query, let offset, let limit):
      return URL(string:"\(baseUrl)/search?api_key=\(apiKey)&q=\(query)&offset=\(offset)&limit=\(limit)")
    }
  }
}
