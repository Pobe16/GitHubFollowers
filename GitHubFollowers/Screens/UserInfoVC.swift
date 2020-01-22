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
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                self.presentMLAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "🙁")
                break
            }
            
        }

    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    


}
