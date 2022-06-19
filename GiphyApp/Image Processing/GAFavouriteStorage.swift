//
//  GAFavouriteStorage.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation
import UIKit
import SDWebImage

class GAFavouriteStorage {
    
    static func getImage(forId id: String) -> UIImage? {
        guard let data = getData(file: id) else {return nil}
        return UIImage.sd_image(with: data)
    }
    
    static func remove(id: String) {
        guard let path = GAFavouritesPlistBuilder.userFavouritesPlistURL?.path else { return }
        if let dic = NSMutableArray.init(contentsOfFile: path) {
            dic.remove(id)
            dic.write(toFile: path, atomically: true)
        }
    }
    
    static func getAllFavourites() -> [String] {
        guard let path = GAFavouritesPlistBuilder.userFavouritesPlistURL?.path else { return []}
        if let dic = NSMutableArray.init(contentsOfFile: path) as? [String]{
            return dic
        }
        return []
    }
    
    static func isFavourite(id: String) -> Bool {
        guard let path = GAFavouritesPlistBuilder.userFavouritesPlistURL?.path else { return false}
        if let dic = NSMutableArray.init(contentsOfFile: path) as? [String]{
            return dic.contains(id)
        }
        return false
    }
    
    static func add(image: UIImage, id: String) {
        guard let path = GAFavouritesPlistBuilder.userFavouritesPlistURL?.path else { return }
        guard let imageData = image.sd_imageData() else { return }
        let dic = NSMutableArray.init(contentsOfFile: path) ?? NSMutableArray(array: [String]())
        dic.add(id)
        dic.write(toFile: path, atomically: true)
        save(data: imageData, file: id)
    }
    static func save(data: Data, file: String) {
        let path = GAFavouritesPlistBuilder.getDirectoryforFile(id: file)
        try? data.write(to: path)
    }
    static func getData(file: String) -> Data? {
        let path = GAFavouritesPlistBuilder.getDirectoryforFile(id: file)
        return try? Data(contentsOf: path)
    }
}
