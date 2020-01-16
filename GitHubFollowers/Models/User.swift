//
//  User.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 16/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import Foundation

struct User: Codable {
    let login:                  String
    // in JSON we have it in snake case, and we need to convert it to camel casae so avatar_url.
    // JSONDecoder() can automatically decode it using decoder.keyDecodingStrategy = .convertFromSnakeCase
    let avatarUrl:              String
    let name:                   String?
    let location:               String?
    let bio:                    String?
    let publicRepos:            Int
    let publicGists:            Int
    let heirable:               Bool?
    let htmlUrl:                String
    let following:              Int
    let followers:              Int
    let createdAt:              String
}
