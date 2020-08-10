//
//  ViewController.swift
//  week11Hwk
//Final Version
//
//
//  Created by Victoria Park on 8/6/20.
//  Copyright © 2020 Victoria Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ninjaView: UIImageView!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    var tapped = false
    var groupAnimation = CAAnimationGroup()
    var moveUp = CABasicAnimation()
    var moveRight = CABasicAnimation()
    var spin = CABasicAnimation()
    var topSelected = false
    var moveRigthSelected = false
    var spinSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpButtons()
        defineAnimations()
       
    }
    
    func setUpButtons(){
        playButton.layer.masksToBounds = true
        playButton.layer.cornerRadius = playButton.frame.width/2
        leftButton.layer.masksToBounds = true
        leftButton.layer.cornerRadius = leftButton.frame.width/2
        rightButton.layer.masksToBounds = true
        rightButton.layer.cornerRadius = playButton.frame.width/2
        topButton.layer.masksToBounds = true
        topButton.layer.cornerRadius = playButton.frame.width/2
        topButton.center.y = playButton.center.y
    }
    
    func defineAnimations(){
        
        moveRight =  CABasicAnimation(keyPath:"position.x")
        moveRight.fromValue = [ninjaView.center.x,ninjaView.center.y]
        moveRight.toValue = [self.view.frame.size.width - ninjaView.frame.width/2,ninjaView.center.y]
        moveRight.duration = 0.5
        ////
        
        spin = CABasicAnimation(keyPath: "transform.rotation.z")
        let numberOfRotations = 6.0
        spin.toValue = Double.pi * 2 * numberOfRotations
        spin.duration = 2.0
        
        ///
       
        moveUp = CABasicAnimation(keyPath:"position.y")
        moveUp.fromValue = [ninjaView.center.x,ninjaView.center.y]
        moveUp.toValue = //[ninjaView.frame.width/2]
            [ninjaView.center.x, 0 + ninjaView.frame.height/2]
        moveUp.duration = 1.0
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        leftButton.isHidden = true
        rightButton.isHidden = true
        topButton.isHidden = true
        
    }
    
    @IBAction func topPressed(_ sender: Any) {
       
        topSelected = true
    
    }
    
    @IBAction func leftPressed(_ sender: Any) {
      
        spinSelected = true
    
    }
    @IBAction func rightPressed(_ sender: Any) {
     
        moveRigthSelected = true
       
    }
    @IBAction func playPressed(_ sender: Any) {
        
        
        if (tapped == true) {
          
            print("tapped is true")
          
          
            UIView.animate(withDuration: 0.2,delay: 0,  animations: {
                        self.topButton.transform = CGAffineTransform.identity
                    })
            UIView.animate(withDuration: 0.2,delay: 0,animations: {
                        self.leftButton.transform = CGAffineTransform.identity
                    })
            UIView.animate(withDuration: 0.2,delay: 0, animations: {
                        self.rightButton.transform = CGAffineTransform.identity
                    })
 
            ninjaView.layer.removeAllAnimations()
            groupAnimation.animations = nil
            CATransaction.begin()
            self.ninjaView.layer.removeAllAnimations()
            self.groupAnimation.animations = nil
            
            CATransaction.setCompletionBlock({
                
                print("animations finished")
                self.tapped = false
                self.topButton.isHidden = true
                self.leftButton.isHidden = true
                self.rightButton.isHidden = true
                //return to original position
                //and remove animations
                self.ninjaView.layer.removeAllAnimations()
                self.groupAnimation.animations = nil
                ////
                self.groupAnimation.fillMode = CAMediaTimingFillMode.forwards
                self.groupAnimation.isRemovedOnCompletion = true
                ///
                self.topSelected = false
                self.moveRigthSelected = false
                self.spinSelected = false
                
                
            })
            
                   print("performing animation")
            
            //***********************************
                //way to add permutations of animations
            if (topSelected && moveRigthSelected && spinSelected){
                    self.groupAnimation.animations = [self.moveUp,self.spin,self.moveRight]
            } else if (topSelected && moveRigthSelected){
                    self.groupAnimation.animations = [self.moveUp,self.moveRight]
            } else if (topSelected && spinSelected){
                   self.groupAnimation.animations = [self.moveUp,self.spin]
            } else if (moveRigthSelected && spinSelected){
                   self.groupAnimation.animations = [self.spin,self.moveRight]
            } else if (topSelected){
                self.groupAnimation.animations = [self.moveUp]
            } else if (moveRigthSelected){
                self.groupAnimation.animations = [self.moveRight]
            } else if (spinSelected){
                self.groupAnimation.animations = [self.spin]
            }
                    self.groupAnimation.duration = 1.0
          
                    self.ninjaView.layer.add(self.groupAnimation, forKey: "animationGroup")
            CATransaction.commit()
           
          
            
        } else {
            //begin state
            tapped = true
            topButton.isHidden = false
            leftButton.isHidden = false
            rightButton.isHidden = false
            UIView.animate(withDuration: 1,delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: [], animations: {
                self.topButton.transform = CGAffineTransform(translationX: 0, y: -100)
            })
            
            UIView.animate(withDuration: 1,delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: [], animations: {
                self.leftButton.transform = CGAffineTransform(translationX: -100, y: 0)
            })
            
            UIView.animate(withDuration: 1,delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: [], animations: {
                self.rightButton.transform = CGAffineTransform(translationX: 100, y: 0)
            })
        }
    }//func
    
    
}//class

