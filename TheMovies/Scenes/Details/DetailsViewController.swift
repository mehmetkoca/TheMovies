//
//  DetailsViewController.swift
//  TheMovies
//
//  Created by Mehmet Koca on 17.10.2020.
//

import UIKit

private enum Constant {
    
    static let moviesTitle = "Movie Details"
    static let personTitle = "Person Details"
    static let emptyStateMessage = "Empty State"
    static let estimatedRowHeight: CGFloat = 200.0
    static let numberOfSections = 2
    
    enum Details: Int {
        
        case description
        case cast
        
        var value: String {
            switch self {
            case .description:
                return "Description"
            case .cast:
                return "Cast"
            }
        }
    }
}

final class DetailsViewController: BaseViewController {
    
    var viewModel: DetailsViewModel!
    var router: DetailsRouter!
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addStateChangeHandler()
        configureViews()
    }
    
    override func loadView() {
        super.loadView()
        
        configureTableView()
    }
}

// MARK: - Configure Views

private extension DetailsViewController {
    
    func configureViews() {
        switch viewModel.purpose {
        case .movie:
            title = Constant.moviesTitle
        case .person:
            title = Constant.personTitle
        }
    }
    
    func configureTableView() {
        tableView.separatorStyle = .none
        tableView.register(DetailsItemCell.self,
                           forCellReuseIdentifier: Global.TableViewCell.detailsItemCell.rawValue)
        tableView.register(ListItemCell.self,
                           forCellReuseIdentifier: Global.TableViewCell.listItemCell.rawValue)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.estimatedRowHeight = Constant.estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDelegate

extension DetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if case DetailsViewModel.Purpose.movie = viewModel.purpose,
           let castId = viewModel.movieCreditsResponse?.cast?[indexPath.row].id,
           indexPath.section == Constant.Details.cast.rawValue {
            router.route(to: .details(purpose: .person, id: castId), from: self)
        }
    }
}

// MARK: - UITableViewDataSource

extension DetailsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int { Constant.numberOfSections }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == Constant.Details.description.rawValue {
            return Constant.Details.description.value
        } else {
            return Constant.Details.cast.value
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Constant.Details.description.rawValue:
            return 1
        case Constant.Details.cast.rawValue:
            switch viewModel.purpose {
            case .movie:
                return viewModel.movieCreditsResponse?.cast?.count ?? 0
            case .person:
                return viewModel.personCreditsResponse?.cast?.count ?? 0
            }
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == Constant.Details.description.rawValue {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Global.TableViewCell.detailsItemCell.rawValue,
                for: indexPath
            ) as? DetailsItemCell else {
                return UITableViewCell()
            }
            
            switch viewModel.purpose {
            case .movie:
                if let movieDetails = viewModel.movieDetailsResponse {
                    let movieDetailsPresentation = MovieDetailsCellPresentation(
                        posterPath: movieDetails.posterPath,
                        title: movieDetails.title,
                        summary: movieDetails.summary,
                        rating: movieDetails.rating
                    )
                    cell.configure(with: movieDetailsPresentation)
                }
            case .person:
                if let person = viewModel.person {
                    let presentation = PersonDetailsCellPresentation(posterPath: person.profilePath,
                                                                     name: person.name,
                                                                     biography: person.biography)
                    cell.configure(with: presentation)
                }
            }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Global.TableViewCell.listItemCell.rawValue,
                for: indexPath
            ) as? ListItemCell else {
                return UITableViewCell()
            }
            switch viewModel.purpose {
            case .movie:
                if let movieCast = viewModel.movieCreditsResponse?.cast?[indexPath.row] {
                    let presentation = PersonListItemCellPresentation(
                        profilePath: movieCast.profilePath,
                        name: movieCast.name
                    )
                    cell.configure(with: presentation)
                }
            case .person:
                if let personCast = viewModel.personCreditsResponse?.cast?[indexPath.row] {
                    let presentation = MovieListItemCellPresentation(
                        posterPath: personCast.posterPath,
                        title: personCast.title,
                        voteAverage: personCast.voteAverage,
                        shouldShowDisclosureIndicator: false
                    )
                    cell.configure(with: presentation)
                }
            }
            
            return cell
        }
    }
}

// MARK: - State Handling

private extension DetailsViewController {
    
    func addStateChangeHandler() {
        self.viewModel.addChangeHandler { [weak self] (change: MovieDetailsChange) in
            guard let strongSelf = self else { return }
            strongSelf.applyStateChange(change)
        }
    }
    
    func applyStateChange(_ change: MovieDetailsChange) {
        DispatchQueue.main.async {
            switch change {
            case .isLoading(let isLoading):
                isLoading ? self.showLoading() : self.hideLoading()
            case .movieDetailsFetched,
                 .movieCreditsFetched,
                 .personDetailsFetched,
                 .personCreditsFetched:
                self.tableView.reloadData()
            case .movieDetailsFetchedFailure,
                 .personDetailsFetchedFailure:
                self.tableView.setEmptyMessage(Constant.emptyStateMessage)
            }
        }
    }
}
