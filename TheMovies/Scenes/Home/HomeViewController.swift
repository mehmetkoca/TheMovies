//
//  HomeViewController.swift
//  TheMovies
//
//  Created by Mehmet Koca on 12.10.2020.
//

import UIKit

private enum Constant {
    
    static let title = "TheMovies"
}

final class HomeViewController: BaseViewController {
    
    var viewModel: HomeViewModel!
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
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
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
