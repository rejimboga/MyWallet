//
//  NSDateExtension.swift
//  MyWallet
//
//  Created by Macbook Air on 21.09.2022.
//

import Foundation

extension Date {
    func getCurrentDate() -> String {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let dateString = dateFormatter.string(from: date as Date)
        return dateString
    }
}
