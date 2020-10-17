//
//  DetailsViewModel.swift
//  TheMovies
//
//  Created by Mehmet Koca on 17.10.2020.
//

enum MovieDetailsChange: StateChange {
    
    case isLoading(_ isLoading: Bool)
    case movieDetailsFetched
    case movieCreditsFetched
    case personDetailsFetched
    case personCreditsFetched
    case movieDetailsFetchedFailure
    case personDetailsFetchedFailure
}

final class DetailsViewModel: StatefulViewModel<MovieDetailsChange> {
    
    enum Purpose {
        
        case movie
        case person
    }
    
    private let moviesService: MoviesServiceProtocol = MoviesService()
    private(set) var movieDetailsResponse: MovieDetailsResponse?
    private(set) var movieCreditsResponse: MovieCreditsResponse?
    
    private let personService: PersonServiceProtocol = PersonService()
    private(set) var person: Person?
    private(set) var personCreditsResponse: PersonCreditsResponse?
    
    private(set) var purpose: Purpose = .movie
    
    init(purpose: Purpose, id: Int) {
        self.purpose = purpose
        super.init()
        
        switch purpose {
        case .movie:
            getMovieDetails(with: id)
        case .person:
            getPersonDetails(with: id)
        }
    }
}

// MARK: - Network

private extension DetailsViewModel {

    func getMovieDetails(with movieId: Int) {
        emit(change: .isLoading(true))
        moviesService.getMovieDetails(id: movieId) { [weak self] result in
            switch result {
            case .success(let response):
                self?.movieDetailsResponse = response
                self?.emit(change: .movieDetailsFetched)
                self?.getMovieCast(with: movieId)
            case .error:
                self?.emit(change: .movieDetailsFetchedFailure)
            }
        }
        
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
    
    func getPersonDetails(with personId: Int) {
        emit(change: .isLoading(true))
        personService.getPersonDetails(id: personId) { [weak self] result in
            self?.emit(change: .isLoading(false))
            switch result {
            case .success(let response):
                self?.person = response
                self?.emit(change: .personDetailsFetched)
                self?.getPersonCast(with: personId)
            case .error:
                self?.emit(change: .personDetailsFetchedFailure)
            }
        }
    }
    
    func getPersonCast(with personId: Int) {
        personService.getPersonCast(id: personId) { [weak self] result in
            self?.emit(change: .isLoading(false))
            switch result {
            case .success(let response):
                self?.personCreditsResponse = response
                self?.emit(change: .personCreditsFetched)
            case .error:
                break
            }
        }
    }
}
