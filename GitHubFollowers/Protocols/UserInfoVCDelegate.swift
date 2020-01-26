//
//  UserInfoVCDelegate.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 26/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import Foundation

protocol UserInfoVCDelegate: class {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}
