//
//  UIImageView+Extension.swift
//  TheMovies
//
//  Created by Mehmet Koca on 15.10.2020.
//

import UIKit

extension UIImageView {
    
    func downloaded(from path: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        
        let posterUrlString = Environment.shared.configuration(.imageUrl)
        var posterURL = URL(string: posterUrlString)
        posterURL?.appendPathComponent(path)
        let queryItems = [URLQueryItem(name: "api_key",
                                       value: Environment.shared.configuration(.apiKey))]
        var urlCompenents = URLComponents(string: posterURL?.absoluteString ?? "")
        urlCompenents?.queryItems = queryItems
        guard let url = urlCompenents?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
