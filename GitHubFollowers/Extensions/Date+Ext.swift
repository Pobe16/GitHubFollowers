//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 25/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//  This was done with course video, but somebody in comments had a better idea.
//  I am leaving this file, just in case.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
        
    }
    
}
