//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 14/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .systemBackground
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { (followers, errorMessage) in
            guard let followers = followers else {
                self.presentMLAlertOnMainThread(title: "Bad Stuff Happened 😭", message: errorMessage!.rawValue, buttonTitle: "Oh no!")
                return
            }
            
            print("Number of followers: \(followers.count)")
            print(followers)
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        
    }

}
