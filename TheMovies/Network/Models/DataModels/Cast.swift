//
//  Cast.swift
//  TheMovies
//
//  Created by Mehmet Koca on 17.10.2020.
//

struct Cast: Codable {
    
    let id: Int?
    let name: String?
    let profilePath: String?
    let castId: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id, name
        case castId = "cast_id"
        case profilePath = "profile_path"
    }
}
