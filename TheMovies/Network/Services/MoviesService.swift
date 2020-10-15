//
//  MoviesService.swift
//  TheMovies
//
//  Created by Mehmet Koca on 15.10.2020.
//

import Foundation

protocol MoviesServiceProtocol {
    
    func getPopularMovies(mediaType: NetworkServices.MediaType,
                          timeWindow: NetworkServices.TimeWindow,
                          completion: @escaping (Result<TrendingMovieResponse>) -> Void)
}

final class MoviesService: MoviesServiceProtocol {
    
    private let networkManager = NetworkManager.shared
    
    func getPopularMovies(mediaType: NetworkServices.MediaType,
                          timeWindow: NetworkServices.TimeWindow,
                          completion: @escaping (Result<TrendingMovieResponse>) -> Void) {
        networkManager.request(target: .popularMovies(mediaType: mediaType, timeWindow: timeWindow),
                               responseType: TrendingMovieResponse.self,
                               completion: completion)
    }
}
