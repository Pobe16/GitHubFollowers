//
//  MLTitleLabel.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 15/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

class MLTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment                          = textAlignment
        self.font                                   = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        
    }
    
    
    private func configure() {
        textColor                                   = .label
        adjustsFontSizeToFitWidth                   = true
        minimumScaleFactor                          = 0.8
        lineBreakMode                               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints   = false
        adjustsFontForContentSizeCategory           = true
        
    }

}
