//
//  MLFollowerInfoVC.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 24/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

protocol MLFollowerItemVCDelegate: class {
    func didTapGetFollowers(for user: User)
}

class MLFollowerItemVC: MLItemInfoVC {
    
    weak var delegate: MLFollowerItemVCDelegate!
    
    
    init(user: User, delegate: MLFollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
