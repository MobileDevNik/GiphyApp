//
//  GAImageCachingCore.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation
import SDWebImage

struct GAImageCachingCore {
  
  static func defineCachingMechanism() {
    
    SDImageCache.shared.config.shouldDisableiCloud = true
    
    SDImageCache.shared.config.shouldCacheImagesInMemory = true
    
    SDImageCache.shared.config.maxMemoryCount = 100

    SDImageCache.shared.config.maxMemoryCost = 80000000
    
    SDImageCache.shared.config.diskCacheExpireType = .accessDate
    
  }
}
