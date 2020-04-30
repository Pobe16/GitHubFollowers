//
//  FavouriteCell.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 29/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

class FavouriteCell: UITableViewCell {
    
    static let reuseID      = "FavouriteCell"
    let avatarImageView     = MLAvatarImageView(frame: .zero)
    let usernameLabel       = MLTitleLabel(textAlignment: .left, fontSize: 26)

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(favourite: Follower) {
        usernameLabel.text = favourite.login
        avatarImageView.downloadImage(fromURL: favourite.avatarUrl)
    }

    
    private func configure() {
        addSubviews(avatarImageView, usernameLabel)
        accessoryType               = .disclosureIndicator
        let padding: CGFloat        = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding*2),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
}
