//
//  GAHomeUseCase.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation

typealias GAHomeResult = Swift.Result<AllGIF, GAHomeUseCaseError>

protocol GAHomeUseCaseProtocol {
  func getDefaultGIFs(offset: Int, limit: Int, completion: @escaping (GAHomeResult) -> ())
  func findGIFs(searchQuery: String, offset: Int, limit: Int, completion: @escaping (GAHomeResult) -> ())
}

enum GAHomeUseCaseError: Error {
  case somethingWentWrong
  
  var description: String {
    switch self {
    case .somethingWentWrong:
        return "Something went wrong!"
    }
  }
}

struct GAHomeUseCase: GAHomeUseCaseProtocol {

    var backendService: GABackendProtocol = GABackendService()
    
    func getDefaultGIFs(offset: Int, limit: Int, completion: @escaping (GAHomeResult) -> ()) {
        let request = GAHomeUseCaseURLBuilder.defaultGIFs(offset: offset, limit: limit)
        backendService.get(request: request, session: URLSession.shared) { (result) in
        switch result {
        case .success(let data):
          do {
            let responseModel = try JSONDecoder().decode(AllGIF.self, from: data)
            completion(.success(responseModel))
          } catch {
            completion(.failure(GAHomeUseCaseError.somethingWentWrong))
          }
        case .failure(_):
          completion(.failure(GAHomeUseCaseError.somethingWentWrong))
        }
      }
    }
    
    func findGIFs(searchQuery: String, offset: Int, limit: Int, completion: @escaping (GAHomeResult) -> ()) {
        let request = GAHomeUseCaseURLBuilder.findGIFs(searchQuery: searchQuery, offset: offset, limit: limit)
        backendService.get(request: request, session: URLSession.shared) { (result) in
        switch result {
        case .success(let data):
          do {
            let responseModel = try JSONDecoder().decode(AllGIF.self, from: data)
            completion(.success(responseModel))
          } catch {
            completion(.failure(GAHomeUseCaseError.somethingWentWrong))
          }
        case .failure(_):
          completion(.failure(GAHomeUseCaseError.somethingWentWrong))
        }
      }
    }
}
