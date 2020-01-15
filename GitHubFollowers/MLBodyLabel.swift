//
//  MLBodyLabel.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 15/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

class MLBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment              = textAlignment
        
        configure()
    }
    
    private func configure() {
        textColor                       = .secondaryLabel
        font                            = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth       = true
        minimumScaleFactor              = 0.75
        lineBreakMode                   = .byWordWrapping
        
        translatesAutoresizingMaskIntoConstraints = false
    }

}
