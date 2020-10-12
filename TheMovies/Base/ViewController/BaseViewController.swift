//
//  BaseViewController.swift
//  TheMovies
//
//  Created by Mehmet Koca on 12.10.2020.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyStyling()
    }
}

// MARK: - Apply Styling

private extension BaseViewController {
    
    func applyStyling() {
        view.backgroundColor = .white
    }
}
