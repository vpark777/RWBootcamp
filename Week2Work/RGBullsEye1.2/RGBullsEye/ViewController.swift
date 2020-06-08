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

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var targetTextLabel: UILabel!
  @IBOutlet weak var guessLabel: UILabel!
  
  @IBOutlet weak var redLabel: UILabel!
  @IBOutlet weak var greenLabel: UILabel!
  @IBOutlet weak var blueLabel: UILabel!
  
  @IBOutlet weak var redSlider: UISlider!
  @IBOutlet weak var greenSlider: UISlider!
  @IBOutlet weak var blueSlider: UISlider!
  
  @IBOutlet weak var roundLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  
  let game = BullsEyeGame()
  var rgb = RGB()
    //rgb is color of live screen on right
    
    
    var quickDiffR:Int{
        return abs(game.targetValue.r - rgb.r)
    }
    var quickDiffG:Int{
        return abs(game.targetValue.g - rgb.g)
    }
    var quickDiffB:Int{
        return abs(game.targetValue.b - rgb.b)
    }
    
  @IBAction func aSliderMoved(sender: UISlider) {
   updateView()
    
    
  }
    
    func getTitle()->String?{
        if (game.points == 100){
             title = "Perfect!"
        } else if (game.points > 95){
               title = "You almost had it!"
        } else if (game.points > 90){
               title = "Pretty good!"
           } else {
               title = "Not even close..."
           }
           return title
       }
  
  @IBAction func showAlert(sender: AnyObject) {
    game.calculateScore(currentGuess: rgb)
    //there shouldn't be empty string but
    if let str1 = getTitle(){
        title = str1
    } else {
        title = "Error"
    }
    let message = "You scored \(game.points) points"
    
    let alert = UIAlertController(title:title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: {
        action in self.game.startNewRound()
        self.resetSliders()
        self.updateView()
    })
    alert.addAction(action)
    present(alert, animated: true, completion:nil)
  }
  
  @IBAction func startOver(sender: AnyObject) {
    game.startNewGame()
    resetSliders()
    updateView()
  }
 func updateScoresFields(){
    
        scoreLabel.text = "Score: \(game.score)"
        roundLabel.text = "Round: \(game.round)"
    }
    func resetSliders(){
        redSlider.value = 128
        greenSlider.value = 128
        blueSlider.value = 128
    }
    
  func updateView() {
    redSlider.isContinuous = true
    greenSlider.isContinuous = true
    blueSlider.isContinuous = true
    
    rgb.r = Int(redSlider.value.rounded())
    redSlider.minimumTrackTintColor = UIColor.red.withAlphaComponent(CGFloat(quickDiffR)/255.0)
    redLabel.text = String(rgb.r)
    
    rgb.g = Int(greenSlider.value.rounded())
    greenSlider.minimumTrackTintColor = UIColor.green .withAlphaComponent(CGFloat(quickDiffG)/255.0)
    greenLabel.text = String(rgb.g)
    
    rgb.b = Int(blueSlider.value.rounded())
    blueSlider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(quickDiffB)/255.0)
    blueLabel.text = String(rgb.b)
    
    guessLabel.backgroundColor = UIColor(rgbStruct:rgb)
    targetLabel.backgroundColor = UIColor(rgbStruct:game.targetValue)
    
    
    print("target value's rgb = r: \(game.targetValue.r) g: \(game.targetValue.g)  g: \(game.targetValue.b)")
    
    print("score is :  \(100 - 100*rgb.difference(target:game.targetValue))")
 
    updateScoresFields()
    
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    game.startNewGame() 
    updateView()
    
    
  }
}

