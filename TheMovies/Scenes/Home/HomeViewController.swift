//
//  HomeViewController.swift
//  TheMovies
//
//  Created by Mehmet Koca on 12.10.2020.
//

import UIKit

private enum Constant {
    
    static let title = "TheMovies"
    static let tableViewHeightForRowAt: CGFloat = 100.0
}

final class HomeViewController: BaseViewController {
    
    var viewModel: HomeViewModel!
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addStateChangeHandler()
        configureViews()
        viewModel.fetchPopularMovies()
    }
    
    override func loadView() {
        super.loadView()
        
        configureTableView()
    }
}

// MARK: - Configure Views

private extension HomeViewController {
    
    func configureViews() {
        title = Constant.title
    }
    
    func configureTableView() {
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        if let movie = viewModel.movies?[indexPath.row] {
            let presentation = MoviewTableViewCellPresentation(posterPath: movie.posterPath,
                                                               title: movie.title,
                                                               voteAverage: movie.voteAverage)
            cell.configure(with: presentation)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.tableViewHeightForRowAt
    }
}

// MARK: - State Handling

private extension HomeViewController {
    
    func addStateChangeHandler() {
        self.viewModel.addChangeHandler { [weak self] (change: HomeStateChange) in
            guard let strongSelf = self else { return }
            strongSelf.applyStateChange(change)
        }
    }
    
    func applyStateChange(_ change: HomeStateChange) {
        switch change {
        case .popularMoviesFetched:
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
