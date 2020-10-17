//
//  PersonDetailsResponse.swift
//  TheMovies
//
//  Created by Mehmet Koca on 17.10.2020.
//

import Foundation

struct PersonDetailsResponse: Codable {
    
    let id: Int?
    let name: String?
    let biography: String?
    let profilePath: String?
}
