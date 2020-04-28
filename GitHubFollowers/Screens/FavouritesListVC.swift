//
//  FavouritesVC.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 13/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

class FavouritesListVC: MLDataLoadingVC {
    
    let tableView                   = UITableView()
    var favourites: [Follower]      = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
        

    }
    
    
    func configureViewController() {
        view.backgroundColor        = .systemBackground
        title                       = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavourites()
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.rowHeight         = 80
        
        tableView.delegate          = self
        tableView.dataSource        = self
        tableView.removeExcessCells()
        
        tableView.register(FavouriteCell.self, forCellReuseIdentifier: FavouriteCell.reuseID)
    }

    
    func getFavourites() {
        PersistenceManager.retrieveFavourites { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let favourites):
                if favourites.isEmpty {
                    self.tableView.isHidden = true
                    self.showEmptyStateView(withMessage: "No Favourites?\nAdd one on the follower screen.", in: self.view)
                } else {
                    self.tableView.isHidden = false
                    self.favourites = favourites
                    DispatchQueue.main.async {
                        self.removeEmptyStateView(in: self.view)
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
            case .failure(let error):
                self.presentMLAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}

extension FavouritesListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.reuseID) as! FavouriteCell
        let favourite = favourites[indexPath.row]
        cell.set(favourite: favourite)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favourite           = favourites[indexPath.row]
        let destinationVC       = FollowerListVC(username: favourite.login)
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete  else { return }
        let favourite           = favourites[indexPath.row]
        
        
        PersistenceManager.updateWith(favourite: favourite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                self.favourites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                if self.favourites.isEmpty {
                    self.tableView.isHidden = true
                    DispatchQueue.main.async {
                        self.showEmptyStateView(withMessage: "No Favourites?\nAdd one on the follower screen.", in: self.view)
                    }
                }
                return
            }
            
            self.presentMLAlertOnMainThread(title: "Unable to remove favourite", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
    
}
