//
//  NetworkProtocol.swift
//  TheMovies
//
//  Created by Mehmet Koca on 15.10.2020.
//

import Foundation

typealias Parameters = [String: Any]
typealias HTTPHeaders = [String: String]

protocol NetworkProtocol {
    
    var baseURL: URL? { get }
    var url: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var parameters: Parameters { get }
}
