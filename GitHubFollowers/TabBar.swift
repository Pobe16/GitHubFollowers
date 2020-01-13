//
//  TabBar.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 13/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NC -> navigation controller
        let searchNC = createSearchNC()
        let favouritesNC = createFavouritesListNC()
        
//        UITabBar.appearance().tintColor = .systemGreen
        
        self.tabBar.tintColor = .systemGreen
        
        self.viewControllers = [searchNC, favouritesNC]
        
        

        // Do any additional setup after loading the view.
    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavouritesListNC() -> UINavigationController {
        let favouritesListVC = FavouritesListVC()
        favouritesListVC.title = "Favourites"
        favouritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favouritesListVC)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
