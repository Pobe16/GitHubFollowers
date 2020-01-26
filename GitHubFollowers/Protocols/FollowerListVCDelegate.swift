//
//  FollowerListVCDelegate.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 26/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import Foundation

protocol FollowerListVCDelegate: class {
    func didRequestFollowers(for username: String)
}
