//
//  HomeRouter.swift
//  TheMovies
//
//  Created by Mehmet Koca on 17.10.2020.
//

import Foundation

enum HomeRoute {
    
    case details(purpose: DetailsViewModel.Purpose, id: Int)
}

protocol HomeRouter: BaseRouter {
    
    func route(to: HomeRoute, from source: HomeViewController)
}

final class DefaultHomeRouter: HomeRouter {
    
    func route(to: HomeRoute, from source: HomeViewController) {
        switch to {
        case .details(let purpose, let id):
            let viewController = DetailsViewController(nibName: nil, bundle: nil)
            let viewModel = DetailsViewModel(purpose: purpose, id: id)
            viewController.viewModel = viewModel
            source.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
