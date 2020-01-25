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
    var name:                   String?
    var location:               String?
    var bio:                    String?
    let publicRepos:            Int
    let publicGists:            Int
    var hirable:                Bool?
    let htmlUrl:                String
    let following:              Int
    let followers:              Int
    // It used String here previously, but someone in comments noted that the data is standarized in ISO 8601
    // So I changed it to Date permanently with a decoder strategy:
    // decoder.dateDecodingStrategy = .iso8601
    let createdAt:              Date
}
