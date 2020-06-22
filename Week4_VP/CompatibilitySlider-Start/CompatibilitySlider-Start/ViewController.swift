//
//  ViewController.swift
//  CompatibilitySlider-Start
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var compatibilityItemLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var questionLabel: UILabel!

    var compatibilityItems = ["Cats", "Dogs","Piano","Vegan food","Lazy"] // Add more!
    var currentItemIndex = 0
    var currentSliderScore:Float = 0.0

    var person1 = Person(id: 1, items: [:])
    var person2 = Person(id: 2, items: [:])
    var currentPerson: Person?

    override func viewDidLoad() {
        super.viewDidLoad()
        currentSliderScore = slider.value
        currentPerson = person1
        newQuestion()
        
    }
    func newQuestion(){
        if (currentPerson == person1) {
        questionLabel.text = "Person1, what do you think about .."
        } else {
        questionLabel.text = "Person2, what do you think about .."
        }
        print("currentItemIndex: \(currentItemIndex)")
        compatibilityItemLabel.text = compatibilityItems[currentItemIndex]
       // currentItemIndex = 0
    }
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print(sender.value)
        currentSliderScore = sender.value
       
    }
    func printArray(){
        print("currentPerson")
        for (key, personRating) in currentPerson!.items{
            print("\(key): \(personRating)")
        }
        
    }

    @IBAction func didPressNextItemButton(_ sender: Any) {
        //get slider score from previous and record
       currentSliderScore = slider.value
        currentPerson?.items[compatibilityItems[currentItemIndex]] = currentSliderScore
        print("value: \(currentPerson?.items[compatibilityItems[currentItemIndex]])")
        
        if (currentItemIndex < compatibilityItems.count-1){
           
            currentItemIndex += 1
            newQuestion()
            
            
        } else {
            print("last item on array branch ")
        
            printArray()
            currentItemIndex = 0
            
            if (currentPerson == person1){
                currentPerson = person2
               
               newQuestion()
            } else {
                
                //restart session on OK with alert
                print("end of game. Compatibility Score: ")
                let score = calculateCompatibility()
                print(score)
                let title = "Results"
                let message = "You two are \(score) compatible"
                

                 let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                 
                 let action = UIAlertAction(title: "OK", style: .default, handler: {
                   action in
                    self.currentPerson = self.person1
                    self.slider.value = 5
                    self.currentSliderScore = self.slider.value
                    self.newQuestion()
                    
                 })
                 
                 alert.addAction(action)
                 
                 present(alert, animated: true, completion: nil)
              
                
            }
        } // if = else
        
        
    }

    func calculateCompatibility() -> String {
        // If diff 0.0 is 100% and 5.0 is 0%, calculate match percentage
        var percentagesForAllItems: [Double] = []

        for (key, person1Rating) in person1.items {
            let person2Rating = person2.items[key] ?? 0
            let difference = abs(person1Rating - person2Rating)/5.0
            percentagesForAllItems.append(Double(difference))
        }

        let sumOfAllPercentages = percentagesForAllItems.reduce(0, +)
        let matchPercentage = sumOfAllPercentages/Double(compatibilityItems.count)
       // print(matchPercentage, "%")
        let matchString = 100 - (matchPercentage * 100).rounded()
        return "\(matchString)%"
    }

}

