//
//  ViewController.swift
//  rgbSlider
//
//  Created by Victoria Park on 5/29/20.
//  Copyright © 2020 Victoria Park. All rights reserved.
//

import UIKit

extension UIColor {
   convenience init(hexString: String, alpha: CGFloat = 1.0) {
       let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
       let scanner = Scanner(string: hexString)
       if (hexString.hasPrefix("#")) {
           scanner.scanLocation = 1
       }
       var color: UInt32 = 0
       scanner.scanHexInt32(&color)
       let mask = 0x000000FF
       let r = Int(color >> 16) & mask
       let g = Int(color >> 8) & mask
       let b = Int(color) & mask
       let red   = CGFloat(r) / 255.0
       let green = CGFloat(g) / 255.0
       let blue  = CGFloat(b) / 255.0
       self.init(red:red, green:green, blue:blue, alpha:alpha)
   }
}

class ViewController: UIViewController {

    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var setColorButton: UIButton!
    @IBOutlet weak var colorNameLabel: UILabel!
    @IBOutlet weak var myBackground: UIImageView!
  
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redNumber: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    
    @IBOutlet weak var blueNumber: UILabel!
   
    var redValue:Float = 0.0
    var greenValue:Float = 0.0
    var blueValue: Float = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSliders()
        myBackground.backgroundColor = UIColor(hexString:"9FFFFF")
        colorNameLabel.text = "Pretty Blue"
        colorNameLabel.layer.cornerRadius = 5
        
        setColorButton.layer.cornerRadius = 5
        resetButton.layer.cornerRadius = 5
        
       
    }
    
    
    @IBAction func redSliderMoved(_ sender: Any) {
        let sliderInt = Int(redSlider.value.rounded())
        redNumber.text = String(sliderInt)
        redValue = redSlider.value
    }
    
    @IBAction func greenSliderMoved(_ sender: Any) {
        let sliderInt = Int(greenSlider.value.rounded())
        greenLabel.text = String(sliderInt)
        greenValue = greenSlider.value
    }
    
    @IBAction func blueSliderMoved(_ sender: Any) {
        let sliderInt = Int(blueSlider.value.rounded())
        blueNumber.text = String(sliderInt)
        blueValue = blueSlider.value
    }
    
    func setBackGroundColor(){
        myBackground.backgroundColor = UIColor(red: CGFloat(redValue/255), green: CGFloat(greenValue/255), blue: CGFloat(blueValue/255), alpha: 1.0)
        print("redValue: \(redValue) greenValue: \(greenValue) blueValue: \(blueValue)")
        
    }
    
    @IBAction func setColorPressed(_ sender: Any) {
        
        let title = "Name your color"
        let alert = UIAlertController(title: title, message:"", preferredStyle: .alert)
        alert.addTextField()
       
        let action = UIAlertAction(title:"Ok",style:.default,handler:{ action in
            self.setBackGroundColor()
            self.colorNameLabel.text = alert.textFields![0].text
           
        })
       
        alert.addAction(action)
        present(alert, animated:true, completion: nil)
        
    }
    
   
    func setUpSliders(){
       
        redSlider.value = 0
        greenSlider.value = 0
        blueSlider.value = 0
        
    }
    func resetColorValues(){
        redValue = 0.0
        greenValue = 0.0
        blueValue = 0.0
        
    }
    func setUpScreen(){
        resetColorValues()
        setUpSliders()
        myBackground.backgroundColor = UIColor(hexString:"9FFFFF")
        colorNameLabel.text = "Pretty Blue"
    }
    @IBAction func resetButtonPressed(_ sender: Any) {
        setUpScreen()
        
    }
   
   

}


