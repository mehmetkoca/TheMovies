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
    let popularity: Double?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, popularity
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
}
