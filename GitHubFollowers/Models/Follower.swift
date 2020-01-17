//
//  Follower.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 16/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import Foundation

struct Follower: Codable, Hashable {
    let login:                  String
    // in JSON we have it in snake case, and we need to convert it to camel casae so avatar_url.
    // JSONDecoder() can automatically decode it using decoder.keyDecodingStrategy = .convertFromSnakeCase
    let avatarUrl:              String
}
