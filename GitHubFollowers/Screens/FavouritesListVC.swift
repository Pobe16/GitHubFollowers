//
//  FavouritesVC.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 13/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

class FavouritesListVC: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        
        PersistenceManager.retrieveFavourites { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let favourites):
                print(favourites)
            case .failure(let error):
                self.presentMLAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }

    }


}
