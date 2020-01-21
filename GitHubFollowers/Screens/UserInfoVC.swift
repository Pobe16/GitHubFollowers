//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 21/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor                = .systemBackground
        
        let doneButton                      = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        
        navigationItem.rightBarButtonItem   = doneButton
        
        print(username ?? "not set yet")

    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    


}
