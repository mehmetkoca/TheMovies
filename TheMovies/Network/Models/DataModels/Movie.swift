//
//  Movie.swift
//  TheMovies
//
//  Created by Mehmet Koca on 12.10.2020.
//

struct Movie: Codable {
    
    let id: Int?
    let title: String?
    let posterPath: String?
    let voteAverage: Double?
    
    private enum CodingKeys: String, CodingKey {
        case id, title
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
}
