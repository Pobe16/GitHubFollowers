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
        getFollowers()
        configureCollectionView()
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
    
    
    func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            
            switch result {
            case .success(let followers):
                self.followers = followers
                
            case .failure(let errorMessage):
                self.presentMLAlertOnMainThread(title: "Bad Stuff Happened 😭", message: errorMessage.rawValue, buttonTitle: "Oh no!")
            }
        }
    }
    
    
    func configureCollectionView() {
        
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createColumnFlowLayout(numberOfColumns: numberOfColumns))
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createColumnFlowLayout(numberOfColumns: 3))
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
    }
    
    func createColumnFlowLayout(numberOfColumns: Int) -> UICollectionViewFlowLayout {
        let width                           = view.bounds.width
        let padding: CGFloat                = 12
        let minimumItemSpacing: CGFloat     = 10
        
        let totalPadding                    = 2 * padding
        let numberOfSpaces                  = numberOfColumns - 1
        let totalSpacing                    = minimumItemSpacing * CGFloat(numberOfSpaces)
        let availableWidth                  = width - totalPadding - totalSpacing
        
        let itemWidth                       = availableWidth / CGFloat(numberOfColumns)
        
        let flowLayout                      = UICollectionViewFlowLayout()
        flowLayout.sectionInset             = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize                 = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
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
