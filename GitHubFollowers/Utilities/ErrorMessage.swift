//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 16/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//

import Foundation

enum ErrorMessage: String {
    case invalidUsername    = "Unable to complete your request. Please check your internet connection."
    case unableToComplete   = "This username created an invalid request. Please try again."
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    
}
