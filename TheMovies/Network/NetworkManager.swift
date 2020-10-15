//
//  NetworkManager.swift
//  TheMovies
//
//  Created by Mehmet Koca on 15.10.2020.
//

import Foundation

final class NetworkManager {
    
    static let shared: NetworkManager = NetworkManager()
    
    private let urlSession = URLSession.shared
    
    private var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        
        return decoder
    }()
    
    private init(){}
    
    func request<T:Decodable>(target: NetworkServices,
                              responseType: T.Type,
                              completion: @escaping ((Result<T>)-> Void)){
        
        var urlRequest: URLRequest
        
        do {
            urlRequest = try buildRequest(with: target)!
            
            self.urlSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
                
                guard let data = data else {
                    completion(.error(.badRequest))
                    return
                }
                
                do {
                    let decodingObject = try self.jsonDecoder.decode(responseType, from: data)
                    completion(.success(decodingObject))
                }catch {
                    completion(.error(.parsingError))
                }
            }.resume()
            
        } catch {
            completion(.error(.badRequest))
        }
    }
    
    private func buildRequest(with target: NetworkServices) throws -> URLRequest? {
        
        guard var urlComponent = URLComponents(url: target.url,
                                               resolvingAgainstBaseURL: true) else {
            throw NetworkError.badRequest
        }
        
        urlComponent.queryItems = URLQueryItem.generate(with: target.parameters)
        
        guard let completedURL = urlComponent.url else { throw NetworkError.badRequest }
        
        var urlRequest = URLRequest(url: completedURL)
        urlRequest.httpMethod = target.httpMethod.name
        urlRequest.allHTTPHeaderFields = target.headers
        
        return urlRequest
    }
}
