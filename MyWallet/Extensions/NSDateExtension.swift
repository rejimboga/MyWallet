//
//  NSDateExtension.swift
//  MyWallet
//
//  Created by Macbook Air on 21.09.2022.
//

import Foundation

extension Date {
    func getCurrentDate(format: DateFormat) -> Date? {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        let dateString = dateFormatter.string(from: date as Date)
        
        let currentDate = dateFormatter.date(from: dateString)
        return currentDate
    }
    
    func toDayString(format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}

enum DateFormat: String {
    case dateWithTime = "dd/MM/yyyy HH:mm"
    case dayOfMonth = "MMMM, dd"
    case hoursWithMinutes = "HH:mm"
}
