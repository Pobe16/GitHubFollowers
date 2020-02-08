//
//  MLAlertContainer.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 08/02/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

class MLAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        layer.cornerRadius    = 16
        layer.borderWidth     = 2
        layer.borderColor     = UIColor.white.cgColor
        backgroundColor       = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
    }
}
