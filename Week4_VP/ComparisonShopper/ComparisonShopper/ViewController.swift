//
//  ViewController.swift
//  ComparisonShopper
//
//  Created by Jay Strawn on 6/15/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Left
    @IBOutlet weak var titleLabelLeft: UILabel!
    @IBOutlet weak var imageViewLeft: UIImageView!
    @IBOutlet weak var priceLabelLeft: UILabel!
    @IBOutlet weak var roomLabelLeft: UILabel!

    // Right
    @IBOutlet weak var titleLabelRight: UILabel!
    @IBOutlet weak var imageViewRight: UIImageView!
    @IBOutlet weak var priceLabelRight: UILabel!
    @IBOutlet weak var roomLabelRight: UILabel!

    var house1: House?
    var house2: House?

    override func viewDidLoad() {
        super.viewDidLoad()
        house1 = House()
        house1?.price = "$12,000"
        house1?.bedrooms = "3 bedrooms"
        house1?.address = "23 Cherry"
       
        setUpLeftSideUI()
        setUpRightSideUI()
        
    }

    func setUpLeftSideUI() {
       
        titleLabelLeft.text = house1!.address!
        priceLabelLeft.text = house1!.price!
        roomLabelLeft.text = house1!.bedrooms!
    }

    func setUpRightSideUI() {
        if house2 == nil {
            titleLabelRight.alpha = 0
            imageViewRight.alpha = 0
            priceLabelRight.alpha = 0
            roomLabelRight.alpha = 0
        } else {
            titleLabelRight.text! = house2!.address!
            priceLabelRight.text! = house2!.price!
            roomLabelRight.text! = house2!.bedrooms!
            titleLabelRight.alpha = 1
            imageViewRight.alpha = 1
            priceLabelRight.alpha = 1
            roomLabelRight.alpha = 1
        }
    }

    @IBAction func didPressAddRightHouseButton(_ sender: Any) {
        openAlertView()
    }

    func openAlertView() {
        let alert = UIAlertController(title: "Alert Title", message: "Alert Message", preferredStyle: UIAlertController.Style.alert)

        alert.addTextField { (textField) in
            textField.placeholder = "address"
        }

        alert.addTextField { (textField) in
            textField.placeholder = "price"
        }

        alert.addTextField { (textField) in
            textField.placeholder = "bedrooms"
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (UIAlertAction) in
          
            self.setupSecondHouse(address1: alert.textFields![0].text!, price1: alert.textFields![1].text!, bedrooms1: alert.textFields![2].text!)
            self.setUpRightSideUI()
        }))

        self.present(alert, animated: true, completion: nil)
    }

    
    func setupSecondHouse(address1:String, price1:String, bedrooms1:String){
        house2 = House(address:address1, price:price1, bedrooms:bedrooms1)
        
        
    }
}

struct House {
    var address: String?
    var price: String?
    var bedrooms: String?
}

