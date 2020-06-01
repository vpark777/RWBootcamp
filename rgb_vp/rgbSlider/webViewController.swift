//
//  webViewController.swift
//  rgbSlider
//
//  Created by Victoria Park on 5/30/20.
//  Copyright © 2020 Victoria Park. All rights reserved.
//

import UIKit
import WebKit

class webViewController: UIViewController, WKUIDelegate {
    @IBOutlet weak var webWindow: WKWebView!
 
    @IBOutlet weak var closeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

       
        closeButton.layer.cornerRadius = 5
        let myURL = URL(string:"https://en.wikipedia.org/wiki/RGB_color_model")
        let myRequest = URLRequest(url: myURL!)
        webWindow.load(myRequest)
    }
    
    @IBAction func close(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
