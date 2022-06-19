//
//  GAFavouritesPlistBuilder.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation
class GAFavouritesPlistBuilder {
    
    static public var userFavouritesPlistURL: URL?
    
    static func build() {
        userFavouritesPlistURL = getDirectoryFavouritesURL()
    }
    
    private static func getDocumentDirectoryURL() -> URL {
        do {
            return try FileManager.default.url(for: .documentDirectory,in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            fatalError("error creating document directory")
        }
    }
    private static func getDirectoryFavouritesURL() -> URL {
        let dicDirURL = getDocumentDirectoryURL()
        let favouritesPlist = dicDirURL.appendingPathComponent("UserFavourites.file")
        if !FileManager.default.fileExists(atPath: favouritesPlist.path) {
            FileManager.default.createFile(atPath: favouritesPlist.path, contents: nil, attributes: nil)
            return favouritesPlist
        } else {
            return favouritesPlist
        }
    }
    static func getDirectoryforFile(id: String) -> URL {
        let dicDirURL = getDocumentDirectoryURL()
        let favouritesPlist = dicDirURL.appendingPathComponent("\(id).file")
        if !FileManager.default.fileExists(atPath: favouritesPlist.path) {
            FileManager.default.createFile(atPath: favouritesPlist.path, contents: nil, attributes: nil)
            return favouritesPlist
        } else {
            return favouritesPlist
        }
    }
}
