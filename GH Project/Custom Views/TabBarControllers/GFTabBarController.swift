//
//  GFTabBarController.swift
//  GH Project
//
//  Created by Andres Gutierrez on 1/1/22.
//

import UIKit

class GFTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemBlue
        self.viewControllers            = [searchNC(), favoritesNC()]
    }
    
    
    func searchNC() -> UINavigationController {
        let searchNC        = SearchVC()
        searchNC.title      = "Search"
        searchNC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchNC)
    }
    
    
    func favoritesNC() -> UINavigationController {
        let favoritesNC = FavoritesVC()
        favoritesNC.title = "Favorites"
        favoritesNC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesNC)
    }
    
    
    // Do we want to change the NavBar appperance?
    //    func configureTabBar(){
    //        UINavigationBar.appearance().tintColor =
    //    }
}
