//
//  GIF.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation

public struct GIF: Codable {
    public let images: Images
    public let id: String
    public let title: String
    
    public func getUrl() -> URL? {
        guard let downUrl = self.images.downsized, let downSizeUrl = URL(string: downUrl.url) else {
            guard let originalUrl = URL(string: self.images.original.url) else { return nil }
            return originalUrl
        }
        return downSizeUrl
    }
}
