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
    var followers: [Follower] = [] {
        didSet {
            updateData()
        }
    }
    
    var collectionView: UICollectionView!
    var numberOfColumns: Int = 3
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        determineNumberOfColumns()
        configureViewController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if previousTraitCollection?.horizontalSizeClass != self.traitCollection.horizontalSizeClass {
            determineNumberOfColumns()
            configureCollectionView()
        }
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func determineNumberOfColumns() {
        let horizontalSize = self.traitCollection.horizontalSizeClass
        switch horizontalSize {
        case .compact:
            numberOfColumns = 3
        case .regular:
            numberOfColumns = 5
        default:
            numberOfColumns = 3
        }
        print("Changing number of columns to \(numberOfColumns)")
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
                self.page += 1
                
            case .failure(let errorMessage):
                self.presentMLAlertOnMainThread(title: "Bad Stuff Happened 😭", message: errorMessage.rawValue, buttonTitle: "Oh no!")
            }
        }
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createColumnFlowLayout(in: view, numberOfColumns: numberOfColumns))
        view.addSubview(collectionView)
        
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
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
        
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
}
