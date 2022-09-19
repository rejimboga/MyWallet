//
//  Balance+CoreDataProperties.swift
//  MyWallet
//
//  Created by Macbook Air on 19.09.2022.
//
//

import Foundation
import CoreData


extension Balance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Balance> {
        return NSFetchRequest<Balance>(entityName: "Balance")
    }

    @NSManaged public var amount: Int64

}

extension Balance : Identifiable {

}
