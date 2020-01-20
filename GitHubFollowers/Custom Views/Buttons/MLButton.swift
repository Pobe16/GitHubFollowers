//
//  MLButton.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 13/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

class MLButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - CUSTOM INITIALISER
    
    init(withColor backgroundColor: UIColor, withTitle title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    
    // MARK: - CUSTOM FUNCS

    
    private func configure() {
        layer.cornerRadius          = 10
        
        setTitleColor(.white, for: .normal)
        
        titleLabel?.font            = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    

}
