//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 14/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var username: String!
    var page: Int = 1
    var userHasMoreFollowers: Bool = true
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username       = username
        title               = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        recalculateLayout(for: size)
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        recalculateLayout(for: view.bounds.size)
    }
    
    func recalculateLayout(for newSize: CGSize) {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        collectionView.collectionViewLayout = UIHelper.updateColumnFlowLayout(for: flowLayout, withNewSize: newSize, numberOfColumns: getNumberOfColumns())
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton                       = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem   = addButton
    }
    
    
    func getNumberOfColumns() -> Int {
        let horizontalSize = self.traitCollection.horizontalSizeClass
        switch horizontalSize {
        case .compact:
            return 3
        case .regular:
            return 5
        default:
            return 3
        }
    }
    
    
    func configureSearchController() {
        let searchController                                    = UISearchController()
        
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.delegate                     = self
        
        searchController.searchBar.placeholder                  = "Seach for username"
        searchController.obscuresBackgroundDuringPresentation   = false
        
        navigationItem.searchController                         = searchController
    }
    
    
    func getFollowers(username: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                if followers.count < 100 {
                    self.userHasMoreFollowers = false
                }
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers. Go follow them 😄."

                    DispatchQueue.main.async {
                        self.showEmptyStateView(withMessage: message, in: self.view)
                    }
                    return
                }
                
                
                self.page += 1
                
                if self.filteredFollowers.isEmpty{
                    self.updateData(on: self.followers)
                } else {
                    DispatchQueue.main.async {
                        self.updateSearchResults(for: self.navigationItem.searchController!)
                    }
                }
                
            case .failure(let errorMessage):
                self.presentMLAlertOnMainThread(title: "Bad Stuff Happened 😭", message: errorMessage.rawValue, buttonTitle: "Oh no!")
            }
        }
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createColumnFlowLayout(in: view, numberOfColumns: getNumberOfColumns()))
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
        collectionView.delegate = self
        
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            
            return cell
        })
    }
    
    func updateData(on followersList: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        
        snapshot.appendItems(followersList)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
    @objc func addButtonTapped() {
        
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                
                let favourite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistenceManager.updateWith(favourite: favourite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    guard let error = error else {
                        self.presentMLAlertOnMainThread(title: "Success!", message: "You have successfully favourited \(user.login)! 🎉", buttonTitle: "Hooray!")
                        return
                    }
                    
                    self.presentMLAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
                }
                
            case .failure(let error):
                self.presentMLAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Oh no 😞")
            }
        }
//        presentMLAlertOnMainThread(title: "Add to favourites", message: "Adding to favourites is not implemented yet. Stay tuned.", buttonTitle: "Okay… 😞")
    }

}

extension FollowerListVC: UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY             = scrollView.contentOffset.y
        let contentHeight       = scrollView.contentSize.height
        let height              = scrollView.frame.size.height
        
        
        if offsetY > contentHeight - height {
            guard userHasMoreFollowers else { return }
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentArray = filteredFollowers.isEmpty ? followers : filteredFollowers
        
        let follower = currentArray[indexPath.item]
        
        let destVC = UserInfoVC()
        destVC.username = follower.login
        destVC.delegate = self
        
        let navController = UINavigationController(rootViewController: destVC)
        
        present(navController, animated: true)
        
    }
}


extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            return
        }
        
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredFollowers.removeAll()
        updateData(on: followers)
    }
}


extension FollowerListVC: FollowerListVCDelegate {
    func didRequestFollowers(for username: String) {
        // get followers for that user
        self.username   = username
        title           = username
        
        page            = 1
        
        
        filteredFollowers.removeAll()
        
        if !(navigationItem.searchController?.searchBar.text?.isEmpty ?? true) {
            navigationItem.searchController?.searchBar.text = ""
            navigationItem.searchController?.isActive = false
            
            DispatchQueue.main.async {
                self.navigationItem.searchController?.searchBar.resignFirstResponder()
                self.navigationItem.searchController?.dismiss(animated: false)
            }
        }
        
        followers.removeAll()
        
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
}
