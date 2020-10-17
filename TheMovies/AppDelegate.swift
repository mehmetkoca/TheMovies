//
//  AppDelegate.swift
//  TheMovies
//
//  Created by Mehmet Koca on 12.10.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let homeViewController = HomeViewController(nibName: nil, bundle: nil)
        let homeViewModel = HomeViewModel(moviesService: MoviesService(),
                                          searchService: SearchService())
        homeViewController.viewModel = homeViewModel
        let homeRouter = DefaultHomeRouter()
        homeViewController.router = homeRouter
        let navigationController = UINavigationController(rootViewController: homeViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}
