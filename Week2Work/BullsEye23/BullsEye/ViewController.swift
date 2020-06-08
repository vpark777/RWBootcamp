//
//  ViewController.swift
//  BullsEye
//
//  Created by Ray Wenderlich on 6/13/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var currentValue = 0
  
  var game = BullsEyeGame()

    var quickDiff:Int{
           return abs(game.targetValue - currentValue)
       }
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!
    
   
    
  override func viewDidLoad() {
    super.viewDidLoad()
  
    game.startNewGame()
    
    updateView()
   
  }
    
    func getTitle()->String?{
        if (quickDiff == 0){
          title = "Perfect!"
        } else if (quickDiff < 5){
            title = "You almost had it!"
        } else if (quickDiff < 10){
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        return title
    }
   

  @IBAction func showAlert() {
    
    game.calculateScore(currentGuess: Int(slider.value.rounded()))
    
    //there shouldn't be empty string but
    if let str1 = getTitle(){
        title = str1
    } else {
        title = "Error"
    }
    let message = "You scored \(game.points) points"
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let action = UIAlertAction(title: "OK", style: .default, handler: {
      action in
        self.game.startNewRound()
        self.updateView()
        
    })
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
    
  }
  
  @IBAction func sliderMoved(_ slider: UISlider) {
    slider.isContinuous = true
    currentValue = Int(slider.value.rounded())
    slider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(quickDiff)/100.0)
    //print(String(currentValue))
    
  }
   
 
  func updateView() {
   // currentLabel.text = String(slider.value)
    targetLabel.text = String(game.targetValue)
    scoreLabel.text = String(game.score)
    roundLabel.text = String(game.round)
    slider.isContinuous = true
    slider.value = 50
  }
  
  @IBAction func startNewGame() {
    game.startNewGame()
    updateView()
  }
  
}



