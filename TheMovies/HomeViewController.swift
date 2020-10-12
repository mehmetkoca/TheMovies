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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
}

// MARK: - Configure Views

private extension HomeViewController {
    
    func configureViews() {
        title = Constant.title
    }
}
