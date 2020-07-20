//
//  SauceAmountData+CoreDataClass.swift
//  SandwichSaturation
//
//  Created by Victoria Park on 7/18/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
//

import Foundation
import CoreData


public class SauceAmountData: NSManagedObject {
        var sauceAmount: SauceAmount{
              get{ //takes sauce amount string and converts into SauceAmount
                 guard let sauceAmountString = self.sauceAmountString,
                   let amount = SauceAmount(rawValue:sauceAmountString)
                   else { return .none}
               return amount
            }//get
        
          set { //takes raw value and sets sauceAmountString
             self.sauceAmountString = newValue.rawValue
          }//set
        }//sauceAmount
}
