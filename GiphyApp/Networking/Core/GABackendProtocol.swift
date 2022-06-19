//
//  GABackendProtocol.swift
//  GiphyApp
//
//  Created by Nikhil Sakhare on 18/06/22.
//

import Foundation
import Foundation

public typealias GABackendResult = Swift.Result<Data, Error>

public enum GABackendServiceError: Error {
  case incorrectUrl
  case incorrectResponse
  
  var description : String{
    switch self {
    case .incorrectUrl:
        return AppStings.Errors.incorrectUrl
    case .incorrectResponse:
        return AppStings.Errors.incorrectResponse
    }
  }
}

private enum RequestType: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
}

public protocol GABackendProtocol {
  func get(request: Request, session: URLSession, completion: @escaping (GABackendResult) -> Void)
}
