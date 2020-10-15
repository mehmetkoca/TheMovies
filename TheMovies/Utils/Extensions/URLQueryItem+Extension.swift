//
//  URLQueryItem+Extension.swift
//  TheMovies
//
//  Created by Mehmet Koca on 15.10.2020.
//

import Foundation

extension URLQueryItem {
    
    static func generate(with params: Dictionary<String,Any>) -> [URLQueryItem]? {
        
        if params.count > 0 {
            var queryItems: [URLQueryItem] = []
            params.forEach { (key, value) in
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
            return queryItems
        }
        return nil
    }
}
