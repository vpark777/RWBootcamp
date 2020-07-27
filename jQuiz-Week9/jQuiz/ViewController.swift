//
//  ViewController.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var clueLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scoreLabel: UILabel!

   
    
    var clues: [Clue] = []
    var correctAnswerClue: Clue?
    var points: Int = 0
    var correctIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        getClues()
     

        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        }

        SoundManager.shared.playSound()
        
    }
    func setUpView(){
       
        DispatchQueue.main.async{
           
            self.categoryLabel.text = self.correctAnswerClue?.category.title
            self.clueLabel.text = self.correctAnswerClue?.question
            self.scoreLabel.text = "\(self.points)"
            self.cutListToFour()
            self.tableView.reloadData()
        }
    }
    func cutListToFour(){
        
        let keyAnswer = correctAnswerClue?.answer
        //remove duplicates and original clue
        
        clues = clues.filter{$0.answer != keyAnswer}
       
        //assuming there are at least 3 clues remain
        
        let newClues = clues.prefix(3)
        clues = Array(newClues)
        
        correctIndex = Int.random(in:0...3)
        print("correct answer index - \(correctIndex)") //for testing scoring
        
        clues.insert(correctAnswerClue!, at:correctIndex)
    }
    
    func getClues(){
        Networking.sharedInstance.getRandomCategory(completion:{(categoryId) in
                 
                  let id = categoryId
                    print("inside completion after getRandomCategory")
            
                  self.correctAnswerClue = Networking.sharedInstance.current_clue
                  print("correct Answer Clue - \(self.correctAnswerClue!.question)")
                   Networking.sharedInstance.getAllCluesInCategory(categoryId: id){ (clues) in
                   self.clues = clues
                    //for testing
                   print("from view controller")
                          for aClue in self.clues{
                              print("from view controller")
                                 print("question: \(aClue.question)")
                                 print("answer: \(aClue.answer)")
                                 print("category id: \(aClue.category_id)")
                              print("__________\n")
                          }
                   //for testing
                   self.setUpView()
                   }
                 })
    }
    
  
    @IBAction func didPressVolumeButton(_ sender: Any) {
        SoundManager.shared.toggleSoundPreference()
        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clues.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cell = UITableViewCell()
        
         let  cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for:indexPath)
        cell.textLabel?.text = clues[indexPath.row].answer
        cell.textLabel?.textAlignment = .center
         
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //correct answer or not and load another
        //set
        print("pressed on index -> \(indexPath.row)")
        if (indexPath.row == correctIndex){
            points = points + 100
        }
        getClues()
        
    }
}

