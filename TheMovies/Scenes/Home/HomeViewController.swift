//
//  HomeViewController.swift
//  TheMovies
//
//  Created by Mehmet Koca on 12.10.2020.
//

import UIKit

private enum Constant {
    
    static let title = "TheMovies"
    static let searchPlaholderText = " Search..."
    static let estimatedRowHeight: CGFloat = 200.0
    
    enum List: Int {
        
        case movies
        case person
        
        var value: String {
            switch self {
            case .movies:
                return "Movies"
            case .person:
                return "Person"
            }
        }
    }
}

final class HomeViewController: BaseViewController {
    
    var viewModel: HomeViewModel!
    var router: HomeRouter!
    
    private lazy var searchBar: UISearchBar = UISearchBar()
    
    private var isSearchActive = false
    
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
        tableView.register(ListItemCell.self,
                           forCellReuseIdentifier: Global.TableViewCell.listItemCell.rawValue)
        tableView.keyboardDismissMode = .interactive
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
    
    func configureSearchBar() {
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = Constant.searchPlaholderText
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
            switch section {
            case 0:
                return viewModel.searchedMovies?.count ?? 0
            case 1:
                return viewModel.searchedPeople?.count ?? 0
            default:
                return 0
            }
        } else {
            return viewModel.movies?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if isSearchActive {
            switch section {
            case Constant.List.movies.rawValue:
                return Constant.List.movies.value
            case Constant.List.person.rawValue:
                return Constant.List.person.value
            default:
                return nil
            }
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Global.TableViewCell.listItemCell.rawValue,
            for: indexPath
        ) as? ListItemCell else {
            return UITableViewCell()
        }
        
        if isSearchActive{
            if indexPath.section == 0,
               let movie = viewModel.searchedMovies?[indexPath.row] {
                let presentation = MovieListItemCellPresentation(
                    posterPath: movie.posterPath,
                    title: movie.title,
                    voteAverage: movie.voteAverage
                )
                cell.configure(with: presentation)
            } else if indexPath.section == 1,
                      let person = viewModel.searchedPeople?[indexPath.row] {
                let presentation = PersonListItemCellPresentation(
                    profilePath: person.profilePath,
                    name: person.name
                )
                cell.configure(with: presentation)
            }
        } else {
            if let movie = viewModel.movies?[indexPath.row] {
                let presentation = MovieListItemCellPresentation(posterPath: movie.posterPath,
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
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearchActive {
            switch indexPath.section {
            case Constant.List.movies.rawValue:
                if let movieId = viewModel.searchedMovies?[indexPath.row].id {
                    router.route(to: .details(purpose: .movie, id: movieId), from: self)
                }
            case Constant.List.person.rawValue:
                if let personId = viewModel.searchedPeople?[indexPath.row].id {
                    router.route(to: .details(purpose: .person, id: personId), from: self)
                }
            default:
                break
            }
        } else {
            if let movieId =  viewModel.movies?[indexPath.row].id {
                router.route(to: .details(purpose: .movie, id: movieId), from: self)
            }
        }
    }
}

// MARK: - UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.handleSearchText(with: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        isSearchActive = true
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
            case .popularMoviesFetched,
                 .searchCompleted:
                self.tableView.reloadData()
            case .searchTextCleared:
                self.isSearchActive = false
                self.tableView.reloadData()
            }
        }
    }
}
