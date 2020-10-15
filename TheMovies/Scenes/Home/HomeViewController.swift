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
    
    private lazy var searchBar: UISearchBar = UISearchBar()
    
    private let tableView = UITableView()

    private var isSearchActive = false
    
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
        configureSearchBar()
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
    
    func configureSearchBar() {
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        tableView.tableHeaderView = searchBar
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        isSearchActive ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchActive {
            return 5
        } else {
            return viewModel.movies?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearchActive {
            if section == 1 {
                return "Movies"
            } else {
                return "Artists"
            }
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell",
                                                       for: indexPath) as? MovieTableViewCell else {
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

// MARK: - UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            isSearchActive = false
            hideLoading()
            tableView.reloadData()
        } else if !isSearchActive {
            isSearchActive = true
            showLoading()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        viewModel.search(with: searchText)
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
        case .isLoading(let isLoading):
            isLoading ? showLoading() : hideLoading()
        case .popularMoviesFetched:
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
