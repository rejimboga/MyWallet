//
//  DataService.swift
//  MyWallet
//
//  Created by Macbook Air on 18.09.2022.
//

import Foundation
import CoreData
import UIKit

class DataService {
    
    func fetchedAmount() -> Int64 {
        guard let balance = fetchedBalance() else { return 0 }
        return balance.amount
    }
    
    func fetchedBalance() -> Balance? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Balance> = Balance.fetchRequest()
        var dataObject: Balance?
        do {
            dataObject = try context.fetch(fetchRequest).last
        } catch {
            print("Couldn't fetch data")
        }
        return dataObject
    }
}

