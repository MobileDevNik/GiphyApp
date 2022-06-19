//
//  GAFavUseCase.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation
import SDWebImage

protocol GAFavUseCaseProtocol {
    mutating func updateFavourites()
    func getFavourites(offset: Int, limit: Int, completion: @escaping ([FavouriteModel]) -> ())
}

enum GAFavUseCaseError: Error {
  case somethingWentWrong
  
  var description: String {
    switch self {
    case .somethingWentWrong:
        return "Something went wrong!"
    }
  }
}

struct GAFavUseCase: GAFavUseCaseProtocol {
    var favoriteModels: [FavouriteModel]?
    init() {
        favoriteModels = getALLFAvourites()
    }
    mutating func updateFavourites() {
        self.favoriteModels = getALLFAvourites()
    }
    func getALLFAvourites() -> [FavouriteModel] {
        let favorites = GAFavouriteStorage.getAllFavourites()
        let model: [FavouriteModel] = favorites.compactMap {
            return FavouriteModel.init(id: $0)
        }
        return model
    }
    func getFavourites(offset: Int, limit: Int, completion: @escaping ([FavouriteModel]) -> ()) {
        guard let fav = favoriteModels else {
            completion([])
            return
        }
        let start = offset * limit
        let last = (offset * limit) + limit
        if start >= fav.count {
            completion([])
            return
        }
        if last > fav.count {
            completion(Array(fav[start..<fav.count]))
            return
        }
        completion(Array(fav[start..<last]))
    }
}
