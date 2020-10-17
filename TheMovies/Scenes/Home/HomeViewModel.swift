//
//  HomeViewModel.swift
//  TheMovies
//
//  Created by Mehmet Koca on 12.10.2020.
//

enum HomeStateChange: StateChange {
    
    case isLoading(_ isLoading: Bool)
    case popularMoviesFetched
    case searhCompleted
}

final class HomeViewModel: StatefulViewModel<HomeStateChange> {
    
    private let moviesService: MoviesServiceProtocol
    private let searchService: SearchServiceProtocol
    
    private(set) var movies: [Movie]? {
        didSet {
            movies?.sort{ $0.popularity ?? 0.0 > $1.popularity ?? 0.0 }
            emit(change: .popularMoviesFetched)
        }
    }
    
    private var searchedMovies: [Movie]? {
        didSet {
            searchedMovies?.sort { $0.popularity ?? 0.0 > $1.popularity ?? 0.0 }
            searchedData.append(searchedMovies)
        }
    }
    
    private var searchedPerson: [Person]? {
        didSet {
            searchedPerson?.sort { $0.popularity ?? 0.0 > $1.popularity ?? 0.0 }
            searchedData.append(searchedPerson)
            emit(change: .searhCompleted)
        }
    }
    
    private(set) var searchedData = [[Any]?]()
    
    init(moviesService: MoviesServiceProtocol, searchService: SearchServiceProtocol) {
        self.moviesService = moviesService
        self.searchService = searchService
    }
}

// MARK: - Network

extension HomeViewModel {
    
    func fetchPopularMovies() {
        emit(change: .isLoading(true))
        moviesService.getPopularMovies(mediaType: .movie, timeWindow: .week) { [weak self] result in
            self?.emit(change: .isLoading(false))
            switch result {
            case .success(let response):
                self?.movies = response.results
            case .error:
                // TODO: Will be implemented
                break
            }
        }
    }
    
    func clearSearchData() {
        searchedData = []
    }
    
    func search(with text: String) {
        searchMovie(with: text)
        searchPerson(with: text)
    }
    
    private func searchMovie(with text: String) {
        emit(change: .isLoading(true))
        searchService.searchMovies(searchText: text) { [weak self] result in
            self?.emit(change: .isLoading(false))
            switch result {
            case .success(let response):
                self?.searchedMovies = response.results
            case .error:
                break
            }
        }
    }
    
    private func searchPerson(with text: String) {
        emit(change: .isLoading(true))
        searchService.searchPerson(searchText: text) { [weak self] result in
            self?.emit(change: .isLoading(false))
            switch result {
            case .success(let response):
                self?.searchedPerson = response.results
            case .error:
                break
            }
        }
    }
}
