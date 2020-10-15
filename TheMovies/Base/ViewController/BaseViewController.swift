//
//  BaseViewController.swift
//  TheMovies
//
//  Created by Mehmet Koca on 12.10.2020.
//

import UIKit

class BaseViewController: UIViewController {
    
    private var indicator = UIActivityIndicatorView()
    
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
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
}

// MARK: - Public Methods

extension BaseViewController {
    
    func showLoading() {
        DispatchQueue.main.async {
            self.activityIndicator()
            self.indicator.startAnimating()
            self.indicator.backgroundColor = .white
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.indicator.hidesWhenStopped = true
        }
    }
}
