//
//  MLAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 17/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

class MLAvatarImageView: UIImageView {
    
    let cache               = NetworkManager.shared.cache
    let placeholderImage    = Images.avatarPlaceholder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius      = 10
        clipsToBounds           = true
        image                   = placeholderImage
        
        translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
}
