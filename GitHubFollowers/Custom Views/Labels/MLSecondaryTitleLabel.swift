//
//  MLSecondaryTitleLabel.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 23/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

class MLSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    
    private func configure() {
        textColor                           = .secondaryLabel
        adjustsFontSizeToFitWidth           = true
        adjustsFontForContentSizeCategory   = true
        minimumScaleFactor                  = 0.9
        lineBreakMode                       = .byTruncatingTail
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
