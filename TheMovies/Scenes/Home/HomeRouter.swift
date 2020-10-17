//
//  HomeRouter.swift
//  TheMovies
//
//  Created by Mehmet Koca on 17.10.2020.
//

import Foundation

enum HomeRoute {
    
    case movieDetails(movieId: Int)
}

protocol HomeRouter: BaseRouter {
    
    func route(to: HomeRoute, from source: HomeViewController)
}

final class DefaultHomeRouter: HomeRouter {
    
    func route(to: HomeRoute, from source: HomeViewController) {
        switch to {
        case .movieDetails(let movieId):
            let viewController = MovieDetailsViewController(nibName: nil, bundle: nil)
            let viewModel = MovieDetailsViewModel(moviesService: MoviesService(),
                                                  movieId: movieId)
            viewController.viewModel = viewModel
            source.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
