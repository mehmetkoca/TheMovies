//
//  HomeViewModel.swift
//  TheMovies
//
//  Created by Mehmet Koca on 12.10.2020.
//

enum HomeStateChange: StateChange {
    
    case isLoading(_ isLoading: Bool)
    case popularMoviesFetched
    case searchCompleted
    case searchTextCleared
}

final class HomeViewModel: StatefulViewModel<HomeStateChange> {
    
    private let moviesService: MoviesServiceProtocol = MoviesService()
    private let searchService: SearchServiceProtocol = SearchService()
    
    private(set) var movies: [Movie]? {
        didSet {
            movies?.sort{ $0.popularity ?? 0.0 > $1.popularity ?? 0.0 }
            emit(change: .popularMoviesFetched)
        }
    }
    
    private(set) var searchedMovies: [Movie]? {
        didSet {
            searchedMovies?.sort { $0.popularity ?? 0.0 > $1.popularity ?? 0.0 }
        }
    }
    
    private(set) var searchedPeople: [Person]? {
        didSet {
            searchedPeople?.sort { $0.popularity ?? 0.0 > $1.popularity ?? 0.0 }
        }
    }
}

// MARK: - Public Methods

extension HomeViewModel {
    
    func handleSearchText(with text: String) {
        if text == "" {
            emit(change: .searchTextCleared)
        }
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
                break
            }
        }
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
                if let movies = response.results {
                    self?.searchedMovies = movies.count == 0 ? nil : movies
                }
                self?.emit(change: .searchCompleted)
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
                if let persons = response.results {
                    self?.searchedPeople = persons.count == 0 ? nil : persons
                }
                self?.emit(change: .searchCompleted)
            case .error:
                break
            }
        }
    }
}
