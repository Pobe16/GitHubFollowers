//
//  String+Ext.swift
//  GitHubFollowers
//
//  Created by Mikolaj Lukasik on 25/01/2020.
//  Copyright © 2020 Mikolaj Lukasik. All rights reserved.
//  This was done with course video, but somebody in comments had a better idea.
//  I am leaving this file, just in case.
//

// MARK: Explanation
// This is not needed, as we don't convert the date manually anymore

//import Foundation
//
//extension String {
//
//    func convertToDate() -> Date? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ssZ"
//        dateFormatter.locale        = Locale(identifier: "pl_PL")
//        dateFormatter.timeZone      = .current
//
//        return dateFormatter.date(from: self)
//    }
//
//    func convertToDisplayFormat() -> String {
//        guard let date = self.convertToDate() else { return "N/A" }
//        return date.convertToMonthYearFormat()
//    }
//}
