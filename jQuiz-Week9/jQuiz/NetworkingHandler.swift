//
//  NetworkingHandler.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//
//////WORKING DIRECTORY

import Foundation

let myURL = "https://www.jservice.io/api/random"
let secondURLString  = "https://www.jservice.io/api/clues/?category="


class Networking {

    static let sharedInstance = Networking()
    private init(){}
   
    public var current_categoryID = 0
    public var cluesList = [Clue]()
    public var current_clue: Clue?
    
    
    func getRandomCategory(completion:@escaping(Int)->()){
   
       if let url = URL(string:myURL){
        
          let session = URLSession(configuration: .default)
          let task = session.dataTask(with:url){ (data,response,error)  in
         
            guard let httpResponse = response as? HTTPURLResponse,
                                  (200..<300).contains(httpResponse.statusCode),
                     let data = data else {
                             fatalError()
                       }
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode([Clue].self, from: data) else {
                                  return
               }//try JSON decode
             self.current_clue = response[0]
             self.current_categoryID = self.current_clue!.category_id
              completion(self.current_categoryID)
              }//if let task
           task.resume()
         
       }//if url
    
    }
    
    func getAllCluesInCategory(categoryId:Int, closure:@escaping([Clue])->()){
        
        let secondURL = secondURLString + "\(current_categoryID)"
            
            if let url = URL(string:secondURL){
               let session = URLSession(configuration: .default)
               let task = session.dataTask(with:url){ (data,response,error)  in
               
                guard let httpResponse = response as? HTTPURLResponse,
                       (200..<300).contains(httpResponse.statusCode),
                       let data = data else {
                         fatalError()
                     }
                let decoder = JSONDecoder()
                guard let response = try? decoder.decode([Clue].self, from: data) else {
                       return
                     }//try JSON decode
                self.cluesList = response
                closure(response)
               }//session.dataTask
            task.resume()
               
            }//if let url
           
        
          }
    
    
}
