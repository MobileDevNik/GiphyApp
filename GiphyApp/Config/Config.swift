//
//  Config.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation
final class GAConfigurations {
    
    enum key: String {
        case apiKey = "API_KEY"
    }
    
    static func apiKey() -> String? {
        guard let configPath = Bundle.main.infoDictionary?[key.apiKey.rawValue] as? String else {
            return nil
        }

        return configPath
    }
}
