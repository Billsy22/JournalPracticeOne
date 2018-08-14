//
//  GlobalFunctions.swift
//  JournalPracticeOne
//
//  Created by Taylor Bills on 8/13/18.
//  Copyright © 2018 Taylor Bills. All rights reserved.
//

import Foundation

class GlobalFunctions {
    
    // MARK: -  Singleton
    static let shared = GlobalFunctions()
    
    // MARK: -  Date Formatter Function
    func formatTimeStamp() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let dateAsFormattedString = dateFormatter.string(from: currentDate)
        return dateAsFormattedString
    }
}
