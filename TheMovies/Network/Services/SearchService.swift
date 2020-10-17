//
//  SearchService.swift
//  TheMovies
//
//  Created by Mehmet Koca on 16.10.2020.
//

import Foundation

protocol SearchServiceProtocol {
    
    func searchMovies(searchText: String, completion: @escaping (Result<MoviesResponse>) -> Void)
    func searchPerson(searchText: String, completion: @escaping (Result<PeopleResponse>) -> Void)
}

final class SearchService: SearchServiceProtocol {
    
    private let networkManager = NetworkManager.shared
    
    func searchMovies(searchText: String, completion: @escaping (Result<MoviesResponse>) -> Void) {
        networkManager.request(target: .search(searchType: .movie, text: searchText),
                               responseType: MoviesResponse.self,
                               completion: completion)
    }
    
    func searchPerson(searchText: String, completion: @escaping (Result<PeopleResponse>) -> Void) {
        networkManager.request(target: .search(searchType: .person, text: searchText),
                               responseType: PeopleResponse.self,
                               completion: completion)
    }
}
