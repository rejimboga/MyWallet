//
//  PaymentExtension.swift
//  MyWallet
//
//  Created by Macbook Air on 22.09.2022.
//

import Foundation
extension Payment {
    @objc var currentDate: String {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: self.date ?? Date())
        }
    }
}
