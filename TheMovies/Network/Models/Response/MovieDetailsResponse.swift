//
//  MovieDetailsResponse.swift
//  TheMovies
//
//  Created by Mehmet Koca on 17.10.2020.
//

struct MovieDetailsResponse: Codable {
    
    let posterPath: String?
    let title: String?
    let summary: String?
    let rating: Double?
    
    private enum CodingKeys: String, CodingKey {
        
        case title
        case posterPath = "poster_path"
        case summary = "overview"
        case rating = "vote_average"
    }
}
