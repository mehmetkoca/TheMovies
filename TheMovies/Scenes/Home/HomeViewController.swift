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
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "searchCell")
        tableView.keyboardDismissMode = .interactive
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
        !viewModel.searchedData.isEmpty ? viewModel.searchedData.count : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !viewModel.searchedData.isEmpty {
            return 5
        } else {
            return viewModel.movies?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !viewModel.searchedData.isEmpty {
            if section == 0 {
                return "Movies"
            } else {
                return "People"
            }
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell",
                                                       for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        if !viewModel.searchedData.isEmpty {
            switch indexPath.section {
            case 0:
                if let movie = viewModel.searchedData[0]?[indexPath.row] as? Movie {
                    let presentation = MoviewTableViewCellPresentation(posterPath: movie.posterPath,
                                                                       title: movie.title,
                                                                       voteAverage: movie.voteAverage)
                    cell.configure(with: presentation)
                }
            case 1:
                if let person = viewModel.searchedData[1]?[indexPath.row] as? Person {
                    let presentation = PersonTableViewCellPresentation(
                        profilePath: person.profilePath, name: person.name
                    )
                    cell.configure(with: presentation)
                }
            default:
                break
            }
        } else {
            if let movie = viewModel.movies?[indexPath.row] {
                let presentation = MoviewTableViewCellPresentation(posterPath: movie.posterPath,
                                                                   title: movie.title,
                                                                   voteAverage: movie.voteAverage)
                cell.configure(with: presentation)
            }
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
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
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
        DispatchQueue.main.async {
            switch change {
            case .isLoading(let isLoading):
                isLoading ? self.showLoading() : self.hideLoading()
            break
            case .popularMoviesFetched,
                 .searhCompleted:
                self.tableView.reloadData()
            }
        }
    }
}
