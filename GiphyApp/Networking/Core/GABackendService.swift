//
//  GABackendService.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation
final public class GABackendService: GABackendProtocol {
  
  public init() { }
  
    public func get(request: Request, session: URLSession, completion: @escaping (GABackendResult) -> Void) {
    if let url = request.url{
      session.dataTask(with: url) { (data, response, error) in
        if let error = error {
          completion(.failure(error))
          return
        }
        guard let data = data else {
          completion(.failure(GABackendServiceError.incorrectResponse))
          return
        }
        completion(.success(data))
      }.resume()
    }else{
      completion(.failure(GABackendServiceError.incorrectUrl))
    }
  }
}
