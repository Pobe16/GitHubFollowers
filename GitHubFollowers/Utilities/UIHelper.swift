//
//  UIHelper.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 18/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import UIKit

struct UIHelper {
    
    static func createColumnFlowLayout(in view: UIView, numberOfColumns: Int) -> UICollectionViewFlowLayout {
        let width                           = view.bounds.width
        let padding: CGFloat                = 12
        let minimumItemSpacing: CGFloat     = 10
        
        let totalPadding                    = 2 * padding
        let numberOfSpaces                  = numberOfColumns - 1
        let totalSpacing                    = minimumItemSpacing * CGFloat(numberOfSpaces)
        let availableWidth                  = width - totalPadding - totalSpacing
        
        let itemWidth                       = availableWidth / CGFloat(numberOfColumns)
        
        let flowLayout                      = UICollectionViewFlowLayout()
        flowLayout.sectionInset             = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize                 = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
}
