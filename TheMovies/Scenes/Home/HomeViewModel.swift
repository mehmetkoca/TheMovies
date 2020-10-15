//
//  HomeViewModel.swift
//  TheMovies
//
//  Created by Mehmet Koca on 12.10.2020.
//

enum HomeStateChange: StateChange {
    
    case popularMoviesFetched
}

final class HomeViewModel: StatefulViewModel<HomeStateChange> {
    
    private let service: MoviesServiceProtocol
    
    private(set) var movies: [Movie]? {
        didSet {
            movies?.sort{ $0.popularity ?? 0.0 > $1.popularity ?? 0.0 }
            emit(change: .popularMoviesFetched)
        }
    }
    
    init(service: MoviesServiceProtocol) {
        self.service = service
    }
}

// MARK: - Network

extension HomeViewModel {
        
    func fetchPopularMovies() {
        service.getPopularMovies(mediaType: .movie, timeWindow: .week) { [weak self] result in
            switch result {
            case .success(let response):
                self?.movies = response.results
            case .error:
                // TODO: Will be implemented
                break
            }
        }
    }
}
