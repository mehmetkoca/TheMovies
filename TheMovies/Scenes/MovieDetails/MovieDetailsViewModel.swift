//
//  MovieDetailsViewModel.swift
//  TheMovies
//
//  Created by Mehmet Koca on 17.10.2020.
//

enum MovieDetailsChange: StateChange {
    
    case isLoading(_ isLoading: Bool)
    case movieDetailsFetched
    case movieCreditsFetched
}

final class MovieDetailsViewModel: StatefulViewModel<MovieDetailsChange> {
    
    private let moviesService: MoviesServiceProtocol
    
    private(set) var movieDetailsResponse: MovieDetailsResponse?
    private(set) var movieCreditsResponse: MovieCreditsResponse?
    
    init(moviesService: MoviesServiceProtocol, movieId: Int) {
        self.moviesService = moviesService
        super.init()
        
        getMovieDetails(with: movieId)
    }
}

// MARK: - Network

private extension MovieDetailsViewModel {

    func getMovieDetails(with movieId: Int) {
        emit(change: .isLoading(true))
        moviesService.getMovieDetails(id: movieId) { [weak self] result in
            switch result {
            case .success(let response):
                self?.movieDetailsResponse = response
                self?.emit(change: .movieDetailsFetched)
            case .error:
                break
            }
        }
        getMovieCast(with: movieId)
    }
    
    func getMovieCast(with movieId: Int) {
        moviesService.getMovieCast(id: movieId) { [weak self] result in
            self?.emit(change: .isLoading(false))
            switch result {
            case .success(let response):
                self?.movieCreditsResponse = response
                self?.emit(change: .movieCreditsFetched)
            case .error:
                break
            }
        }
    }
}
