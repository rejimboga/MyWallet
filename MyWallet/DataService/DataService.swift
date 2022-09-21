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
    
    static let shared = DataService()
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func fetchedAmount() -> Int64 {
        guard let balance = fetchedBalance()?.last else { return 0 }
        return balance.balance
    }
    
    func fetchedBalance() -> [Balance]? {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Balance> = Balance.fetchRequest()
        var dataObject: [Balance]?
        do {
            dataObject = try context.fetch(fetchRequest)
        } catch {
            print("Couldn't fetch data")
        }
        return dataObject
    }
    
    func saveAmount(balance: Int64, amount: Int64, date: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Balance", in: context) else { return }
        
        let balanceObject = Balance(entity: entity, insertInto: context)
        balanceObject.balance = balance
        balanceObject.amount = amount
        balanceObject.date = date
        do {
            try context.save()
        } catch {
            print("Couldn't save data")
        }
    }
}
