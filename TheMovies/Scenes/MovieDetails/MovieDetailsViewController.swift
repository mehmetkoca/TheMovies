//
//  MovieDetailsViewController.swift
//  TheMovies
//
//  Created by Mehmet Koca on 17.10.2020.
//

import UIKit

private enum Constant {
    
    static let title = "Movie Details"
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
        tableView.register(MovieDetailsCell.self, forCellReuseIdentifier: "movieDetailsCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
    }
}
// MARK: - UITableViewDataSource

extension MovieDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieDetailsCell",
                                                       for: indexPath) as? MovieDetailsCell else {
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
            case .movieDetailsFetched:
                self.tableView.reloadData()
            }
        }
    }
}
