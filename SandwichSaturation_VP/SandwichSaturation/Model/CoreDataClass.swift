//
//  CoreDataClass.swift
//  SandwichSaturation
//
//  Created by Victoria Park on 7/14/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

/*You cannot store your SauceAmount enum directly into Core Data. Instead, consider creating a separate Core Data Entity called something like SauceAmountModel that contains a single String attribute. You can then create a relationship between this new Entity and your Sandwich model. Inside the Core Data Class extension for your SauceAmount entity, create a computed property that will convert this String to and from SauceAmount. Because I’m nice, I’m going to give you that exact code needed for SauceAmountModel+CoreDataClass.swift (or whatever you name it) here:

(The get takes your SauceAmountModel String and converts it to a SauceAmount. The set takes the rawValue of a SauceAmount and uses it to set the String)
You’ll need to change your sandwiches and filteredSandwiches arrays to the type of your new NSManagedObject
saveSandwich(_:) and filterContentForSearchText(_:) will both need changes to save and read from Core Data respectively.
For filtering, you may want to use a NSCompoundPredicate.
Use NSCompoundPredicate(orPredicateWithSubpredicates:) to combine your sandwich saturation options selected by the scope bar (Too Much and None) if the user has selected Any. This means items with either of those options will be selected.
Otherwise, use the specific SauceAmount that was chosen
You’ll need to use NSCompoundPredicate(andPredicateWithSubpredicates:) to join the scope bar and search text predicates before kicking off a fetch.
*/
/*
import Foundation
import CoreData

@objc(SandwichCoreData)
public class SandwichCoreData:NSManagedObject{
    var name:String
    var sauceAmount:SauceAmountModel
    var imageName: String
    
}

 @objc(SauceAmountModel)
public class SauceAmountModel: NSManagedObject{
    var sauceAmount: SauceAmount{
       get{ //takes sauce amount string and converts into SauceAmount
          guard let sauceAmountString = self.SauceAmountString,
            let amount = SauceAmount(rawValue:sauceAmountString)
            else { return .none}
        return amount
     }//get
 
   set { //takes raw value and sets sauceAmountString
      set.sauceAmountString = newValue.rawValue
   }//set
 }//sauceAmount
}

*/
