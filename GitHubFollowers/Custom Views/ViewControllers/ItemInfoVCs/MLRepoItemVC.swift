//
//  MLRepoItemVC.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 24/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

protocol MLRepoItemVCDelegate: class {
    func didTapGitHubProfile(for user: User)
}


class MLRepoItemVC: MLItemInfoVC {
    
    weak var delegate: MLRepoItemVCDelegate!
    
    init(user: User, delegate: MLRepoItemVCDelegate) {
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
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
