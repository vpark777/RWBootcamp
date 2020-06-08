//
//  BullsEyeGame.swift
//  BullsEye
//
//  Created by Victoria Park on 6/6/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import Foundation

class BullsEyeGame{
    
    var targetValue = 0
    var score = 0
    var round = 0
    var points = 0
    
   
    func startNewGame(){
        score = 0
        round = 0
        startNewRound()
    }
    func startNewRound(){
        round += 1
        targetValue = Int.random(in:1...100)
       
        
    }
    
    func calculateScore(currentGuess: Int){
        let difference = abs(currentGuess - targetValue)
        var points = 100 - difference
        //award bonus points
        if difference == 0{
            points += 100
        } else if difference < 5 {
            if difference == 1 {
                points += 50
            }
        }
        self.points = Int(points)
        score += points
        
    }
}
