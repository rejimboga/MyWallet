//
//  StringExtension.swift
//  MyWallet
//
//  Created by Macbook Air on 21.09.2022.
//

import Foundation

extension String {
    func toDay(format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let date = dateFormatter.date(from: self)
        
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: date ?? Date())
        
    }    
}
