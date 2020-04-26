//
//  UIView+Ext.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 26/04/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
