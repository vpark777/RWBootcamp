//
//  DataGenerator.swift
//  SandwichSaturation
//
//  Created by Victoria Park on 7/14/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import Foundation

class DataGenerator {
    static let shared = DataGenerator()
    private init() { }
    
    func generateData() -> [SandwichData]? {
        
        if let filePath = Bundle.main.path(forResource: "sandwiches", ofType: "json") {
            let fileURL = URL(fileURLWithPath: filePath)
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([SandwichData].self, from: data)
                return decodedData
            } catch let error {
                print("Error in parsing \(error.localizedDescription)")
            }
        }
        return nil
    }//function
}//class
