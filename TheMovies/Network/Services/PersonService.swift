//
//  PersonService.swift
//  TheMovies
//
//  Created by Mehmet Koca on 17.10.2020.
//

import Foundation

protocol PersonServiceProtocol {
    
    func getPersonDetails(id: Int, completion: @escaping (Result<Person>) -> Void)
    func getPersonCast(id: Int, completion: @escaping (Result<PersonCreditsResponse>) -> Void)
}

final class PersonService: PersonServiceProtocol {

    private let networkManager = NetworkManager.shared
    
    func getPersonDetails(id: Int, completion: @escaping (Result<Person>) -> Void) {
        networkManager.request(target: .personDetails(mediaType: .person, id: id),
                               responseType: Person.self,
                               completion: completion)
    }
    
    func getPersonCast(id: Int, completion: @escaping (Result<PersonCreditsResponse>) -> Void) {
        networkManager.request(target: .personCast(mediaType: .person, id: id),
                               responseType: PersonCreditsResponse.self,
                               completion: completion)
    }
}
