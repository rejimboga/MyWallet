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
    
    func fetchedAmount() -> Double {
        guard let balance = fetchedBalance()?.last else { return 0 }
        return balance.currentBalance
    }
    
    func fetchedBalance() -> [Payment]? {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Payment> = Payment.fetchRequest()
        var dataObject: [Payment]?
        do {
            dataObject = try context.fetch(fetchRequest)
        } catch {
            print("Couldn't fetch data")
        }
        return dataObject
    }
    
    func saveAmount(currentBalance: Double, amount: Double, date: Date, category: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Payment", in: context) else { return }
        let balanceObject = Payment(entity: entity, insertInto: context)
        guard let categoryType = CategoryType(rawValue: category) else { return }
        balanceObject.currentBalance = currentBalance
        balanceObject.amount = categoryType.transactionType(amount: amount)
        balanceObject.category = category
        balanceObject.date = date
        do {
            try context.save()
        } catch {
            print("Couldn't save data")
        }
    }
}
