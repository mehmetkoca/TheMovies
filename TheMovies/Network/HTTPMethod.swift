//
//  HTTPMethod.swift
//  TheMovies
//
//  Created by Mehmet Koca on 15.10.2020.
//

enum HTTPMethod: String {
    
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    
    var name: String {
        return self.rawValue
    }
}
