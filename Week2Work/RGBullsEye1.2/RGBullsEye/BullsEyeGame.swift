/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import Foundation

class BullsEyeGame {
    var score = 0
    var round = 0
    var targetValue = RGB()
    var points = 0
  
    
    func startNewGame(){
        score = 0
        round = 0
        startNewRound()
    }
    func startNewRound(){
        round += 1
        
        getNewTargetValues()
       //update views from viewcontroller
    }
    func calculateScore(currentGuess: RGB){
        let difference = Int(100*currentGuess.difference(target:self.targetValue))
        var points = 100 - difference
        
       
        
        if difference == 0{
            points += 100
        } else if difference < 5 {
            if difference == 1 {
                points += 50
            }
        }
        self.points = points
        score += points
        
    }
    func getNewTargetValues(){
        targetValue.r = Int.random(in: 0...255)
        targetValue.g = Int.random(in: 0...255)
        targetValue.b = Int.random(in: 0...255)
    }
    
    
    
   
    
}
