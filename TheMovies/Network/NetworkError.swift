//
//  NetworkError.swift
//  TheMovies
//
//  Created by Mehmet Koca on 15.10.2020.
//

import Foundation

enum NetworkError: Error {
    
    case failure(_ message: String)
    case badRequest
    case parsingError
    case serverIsNotResponding
    
    var errorDescription: String? {
        switch self {
          case .failure(let message):
              return message
          case .badRequest:
              return "Bad Request"
          case .serverIsNotResponding:
              return "Server is not responding"
          case .parsingError:
              return "Parsing Error"
          }
    }
}

extension NetworkError: LocalizedError {}
