//
//  Person.swift
//  TheMovies
//
//  Created by Mehmet Koca on 16.10.2020.
//

import Foundation

struct Person: Codable {
    
    let id: Int?
    let name: String?
    let popularity: Double?
    let profilePath: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, popularity
        case profilePath = "profile_path"
    }
}
