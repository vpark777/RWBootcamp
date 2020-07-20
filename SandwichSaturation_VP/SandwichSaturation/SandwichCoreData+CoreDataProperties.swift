//
//  SandwichCoreData+CoreDataProperties.swift
//  SandwichSaturation
//
//  Created by Victoria Park on 7/18/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
//

import Foundation
import CoreData


extension SandwichCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SandwichCoreData> {
        return NSFetchRequest<SandwichCoreData>(entityName: "SandwichCoreData")
    }

    @NSManaged public var name: String?
    @NSManaged public var imageName: String?
    @NSManaged public var sauceAmount: String?
    @NSManaged public var sauciness: SauceAmountData?

}
