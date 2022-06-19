//
//  GIFModel.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation

struct GIFModel<T: Any> {
    var models: [T] = [T]()
    var offset: Int = 0
    var limit: Int = 20
    
    init() {}
    
    mutating func addNewData(model: [T]) {
        models.append(contentsOf: model)
        offset += 1
    }
    
    mutating func reset() {
        self.offset = 0
        self.limit = 20
        self.models = [T]()
    }
    
    func getNextOffset() -> Int{
        return offset
    }
}
