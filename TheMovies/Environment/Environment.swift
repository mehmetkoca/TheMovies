//
//  Environment.swift
//  TheMovies
//
//  Created by Mehmet Koca on 15.10.2020.
//

import Foundation

final class Environment {
    
    enum Value: String {
        
        // TODO: Do not store base url and api key in project
        case baseUrl = "https://api.themoviedb.org/3/"
        case apiKey = "49bb1e22aafd31834c4a453adc14c9e6"
    }
    
    static let shared: Environment = Environment()
    
    // TODO: Retrieve security credentials with xcconfig and own info plist
    func configuration(_ value: Value) -> String {
        return value.rawValue
    }
}
