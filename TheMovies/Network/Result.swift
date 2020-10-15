//
//  Result.swift
//  TheMovies
//
//  Created by Mehmet Koca on 15.10.2020.
//

enum Result<Object> {
    
    case success(Object)
    case error(NetworkError)
}
