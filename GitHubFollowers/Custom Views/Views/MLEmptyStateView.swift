//
//  MLEmptyStateView.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 20/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

class MLEmptyStateView: UIView {
    
    let messageLabel    = MLTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView   = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    private func configure() {
        addSubview(messageLabel)
        addSubview(logoImageView)
        
        messageLabel.numberOfLines          = 3
        messageLabel.textColor              = .secondaryLabel
        
        logoImageView.image = UIImage(named: "empty-state-logo")
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -130),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            logoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            logoImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            logoImageView.centerXAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])
        
    }
}
