//
//  SauceAmountData+CoreDataProperties.swift
//  SandwichSaturation
//
//  Created by Victoria Park on 7/18/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
//

import Foundation
import CoreData


extension SauceAmountData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SauceAmountData> {
        return NSFetchRequest<SauceAmountData>(entityName: "SauceAmountData")
    }

    @NSManaged public var sauceAmountString: String?
    @NSManaged public var foodItem: NSSet?

}

// MARK: Generated accessors for foodItem
extension SauceAmountData {

    @objc(addFoodItemObject:)
    @NSManaged public func addToFoodItem(_ value: SandwichCoreData)

    @objc(removeFoodItemObject:)
    @NSManaged public func removeFromFoodItem(_ value: SandwichCoreData)

    @objc(addFoodItem:)
    @NSManaged public func addToFoodItem(_ values: NSSet)

    @objc(removeFoodItem:)
    @NSManaged public func removeFromFoodItem(_ values: NSSet)

}
