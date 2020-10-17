//
//  NetworkServices.swift
//  TheMovies
//
//  Created by Mehmet Koca on 15.10.2020.
//

import Foundation

enum NetworkServices {
    
    //Movie
    case popularMovies(mediaType: MediaType, timeWindow: TimeWindow)
    case movieDetails(mediaType: MediaType, id: Int)
    case movieCast(mediaType: MediaType, id: Int)
    
    // Search
    case search(searchType: SearchType, text: String)
}

extension NetworkServices {
    
    enum Key: String {
        
        case apikey
        case page
        case limit
        
        var name: String {
            return self.rawValue
        }
    }
    
    enum MediaType: String {
        
        case movie
        
        var name: String {
            return self.rawValue
        }
    }
    
    enum TimeWindow: String {
        
        case day
        case week
        
        var name: String {
            return self.rawValue
        }
    }
    
    enum SearchType: String {
        
        case movie
        case person
        
        var name: String {
            return self.rawValue
        }
    }
}

// MARK: - NetworkProtocol

extension NetworkServices: NetworkProtocol {
    
    var baseURL: URL? { URL(string: getBaseUrlString()) }
    
    var path: String {
        switch self {
        case .popularMovies(let mediaType, let timeWindow):
            return "trending/\(mediaType.name)/\(timeWindow.name)"
        case .search(let searchType, _):
            return "search/\(searchType.name)"
        case .movieDetails(let mediaType, let id):
            return "\(mediaType.name)/\(id)"
        case .movieCast(let mediaType, let id):
            return "\(mediaType.name)/\(id)/credits"
        }
    }
    
    var url: URL { URL(string: self.path, relativeTo: self.baseURL)! }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .popularMovies,
             .search,
             .movieDetails,
             .movieCast:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        return ["Accept": "application/json"]
    }
    
    var parameters: Parameters {
        switch self {
        case .search(_, let text):
            return ["api_key":Environment.shared.configuration(.apiKey),
                    "query": "\(text)"]
        default:
            return ["api_key":Environment.shared.configuration(.apiKey)]
        }
    }
    
    private func getBaseUrlString() -> String {
        var urlString: String = ""
        
        urlString = Environment.shared.configuration(.baseUrl)
        
        return urlString
    }
    
    private func getApiKey() -> String {
        var apiKey: String = ""
        
        apiKey = Environment.shared.configuration(.apiKey)
        
        return apiKey
    }
}
