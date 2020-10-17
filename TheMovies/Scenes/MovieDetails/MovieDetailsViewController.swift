//
//  MovieDetailsViewController.swift
//  TheMovies
//
//  Created by Mehmet Koca on 17.10.2020.
//

import UIKit

private enum Constant {
    
    static let title = "Movie Details"
    static let estimatedRowHeight: CGFloat = 200.0
    
    enum MovieDetails: Int {
        
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
        
        var cellIdentifier: String {
            switch self {
            case .description:
                return "movieDetailsCell"
            case .cast:
                return "movieCastCell"
            }
        }
    }
}

final class MovieDetailsViewController: BaseViewController {
    
    var viewModel: MovieDetailsViewModel!
    
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

private extension MovieDetailsViewController {
    
    func configureViews() {
        title = Constant.title
    }
    
    func configureTableView() {
        tableView.separatorStyle = .none
        tableView.register(MovieDetailsCell.self,
                           forCellReuseIdentifier: Constant.MovieDetails.description.cellIdentifier)
        tableView.register(MovieCastCell.self,
                           forCellReuseIdentifier: Constant.MovieDetails.cast.cellIdentifier)
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

extension MovieDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource

extension MovieDetailsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == Constant.MovieDetails.description.rawValue {
            return Constant.MovieDetails.description.value
        } else {
            return Constant.MovieDetails.cast.value
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Constant.MovieDetails.description.rawValue:
            return 1
        case Constant.MovieDetails.cast.rawValue:
            return viewModel.movieCreditsResponse?.cast?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == Constant.MovieDetails.description.rawValue {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constant.MovieDetails.description.cellIdentifier,
                for: indexPath
            ) as? MovieDetailsCell else {
                return UITableViewCell()
            }
            
            if let movieDetails = viewModel.movieDetailsResponse {
                let movieDetailsPresentation = MovieDetailsCellPresentation(
                    posterPath: movieDetails.posterPath,
                    title: movieDetails.title,
                    summary: movieDetails.summary,
                    rating: movieDetails.rating
                )
                cell.configure(with: movieDetailsPresentation)
            }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constant.MovieDetails.cast.cellIdentifier,
                for: indexPath
            ) as? MovieCastCell else {
                return UITableViewCell()
            }
            
            if let movieCast = viewModel.movieCreditsResponse?.cast?[indexPath.row] {
                let presentation = MovieCastCellPresentation(profilePath: movieCast.profilePath,
                                                             name: movieCast.name)
                cell.configure(with: presentation)
            }
            return cell
        }
    }
}

// MARK: - State Handling

private extension MovieDetailsViewController {
    
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
                 .movieCreditsFetched:
                self.tableView.reloadData()
            }
        }
    }
}
