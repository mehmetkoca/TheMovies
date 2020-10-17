//
//  PersonService.swift
//  TheMovies
//
//  Created by Mehmet Koca on 17.10.2020.
//

import Foundation

protocol PersonServiceProtocol {
    
    func getPersonDetails(id: Int, completion: @escaping (Result<Person>) -> Void)
}

final class PersonService: PersonServiceProtocol {
    
    private let networkManager = NetworkManager.shared
    
    func getPersonDetails(id: Int, completion: @escaping (Result<Person>) -> Void) {
        networkManager.request(target: .personDetails(mediaType: .person, id: id),
                               responseType: Person.self,
                               completion: completion)
    }
}
