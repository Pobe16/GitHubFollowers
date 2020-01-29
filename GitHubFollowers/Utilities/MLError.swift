//
//  MLError.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 16/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import Foundation

enum MLError: String, Error {
    case invalidUsername    = "Unable to complete your request. Please check your internet connection."
    case unableToComplete   = "This username created an invalid request. Please check your internet connection, and try again."
    case invalidResponse    = "Invalid response from the server. Possibly unknown user. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    
}
