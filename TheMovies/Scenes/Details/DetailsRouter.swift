//
//  DetailsRouter.swift
//  TheMovies
//
//  Created by Mehmet Koca on 17.10.2020.
//

import Foundation

enum DetailsRoute {
    
    case details(purpose: DetailsViewModel.Purpose, id: Int)
}

protocol DetailsRouter: BaseRouter {
    
    func route(to: DetailsRoute, from source: DetailsViewController)
}

final class DefaultDetailsRouter: DetailsRouter {

    func route(to: DetailsRoute, from source: DetailsViewController) {
        switch to {
        case .details(let purpose, let id):
            let viewController = DetailsViewController(nibName: nil, bundle: nil)
            let viewModel = DetailsViewModel(purpose: purpose, id: id)
            viewController.viewModel = viewModel
            viewController.router = DefaultDetailsRouter()
            source.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
