//
//  ViewController.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//image picker shows up but doesnt seem to be
//calling the delegate function for some reason

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet weak var tableview: UITableView!
    var tempImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setUpTableView()
        MediaPostsHandler.shared.getPosts()
       
    }
    //mark tableview delegate and datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return MediaPostsHandler.shared.mediaPosts.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
           var cell:UITableViewCell?
           
         //  print("cellForRowAt: \(indexPath.row)")
           if let textPost = MediaPostsHandler.shared.mediaPosts[indexPath.row] as? TextPost{
              let  cell = tableView.dequeueReusableCell(withIdentifier: "textPostCell", for:indexPath)
               configureTextPost(for: cell, with: textPost)
             
               return cell
           } else if let imagePost = MediaPostsHandler.shared.mediaPosts[indexPath.row] as? ImagePost{
             let   cell = tableView.dequeueReusableCell(withIdentifier: "imagePostCell", for:indexPath)
               configureImagePost(for: cell, with: imagePost)
               return cell
           }
           
           return cell ?? UITableViewCell()
       }
       

    func configureTextPost(for cell: UITableViewCell, with post:TextPost){
         if let label = cell.viewWithTag(30) as? UILabel {
         label.text = post.textBody
           
        }
        if let label = cell.viewWithTag(10) as? UILabel{
            label.text = post.userName
        }
        if let label = cell.viewWithTag(20) as? UILabel{
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM, HH:mm"
            label.text = formatter.string(from:post.timestamp)
           
            
        }
           
    }
    func configureImagePost(for cell: UITableViewCell, with post:ImagePost){
        
        if let label = cell.viewWithTag(40) as? UILabel{
           label.text = post.userName
        }
        if let label = cell.viewWithTag(50) as? UILabel{
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM, HH:mm"
            label.text = formatter.string(from:post.timestamp)
        }
        if let label = cell.viewWithTag(60) as? UILabel{
           label.text = post.textBody
        }
        if let imageView = cell.viewWithTag(70) as? UIImageView{
            imageView.image = post.image
        }
       
    }
    func setUpTableView() {
       
       tableview.dataSource = self
       tableview.delegate = self
       
       
    }

    func createPost(hasImage:Bool){
         let newRowIndex = MediaPostsHandler.shared.mediaPosts.count
        
               var txtUsername : UITextField?
               var text: UITextField?
          
        print("inside create post")
           let alert = UIAlertController(title: "Create Post", message: "What's up? :]", preferredStyle: .alert)
              
           alert.addTextField()
           alert.addTextField()
           let action = UIAlertAction(title: "OK", style: .default, handler: {
                  action in
               if let userName1 = alert.textFields![0].text, let textBody1 = alert.textFields![1].text{
                   if (userName1.count != 0) && (textBody1.count != 0){
                    if (hasImage == true){
                        print("creating image post")
                        let imagePost1 = ImagePost(textBody:textBody1, userName:userName1, timestamp:Date(), image:self.tempImage!)
                        MediaPostsHandler.shared.addImagePost(imagePost:imagePost1)
                         let indexPath = IndexPath(row: newRowIndex, section:0)
                         let indexPaths = [indexPath]
                                self.tableview.insertRows(at: indexPaths, with: .automatic)
                        self.tableview.reloadData()
                    } else {
                        print("creating text post")
                       let textPost1 = TextPost(textBody:textBody1, userName:userName1, timestamp:Date())
                       MediaPostsHandler.shared.addTextPost(textPost:textPost1)
                        let indexPath = IndexPath(row: newRowIndex, section:0)
                        let indexPaths = [indexPath]
                               self.tableview.insertRows(at: indexPaths, with: .automatic)
                       self.tableview.reloadData()
                      } //if
                    }//if it's an imagePost
                           }//if
                      })

               
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action  in
                print("Cancel button tapped")
               self.dismiss(animated: true, completion: nil)
               }
                                             
            alert.addAction(action)
           alert.addAction(cancelAction)
                       
            present(alert, animated: true, completion: nil)
    }
    @IBAction func didPressCreateTextPostButton(_ sender: Any) {
     
        createPost(hasImage:false)
    }
    

    @IBAction func didPressCreateImagePostButton(_ sender: Any) {
           let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = false
       // pickerController.mediaTypes = ["public.image"]
        
        pickerController.sourceType = .photoLibrary
       pickerController.modalPresentationStyle = .fullScreen
        print("did press imagepost before presenting image picker")
        present(pickerController, animated: true,completion:nil)
        print("after presenting picker completed")
       // pickerController.dismiss(animated:true)
      
        
       
        
    }

}
extension ViewController:UIImagePickerControllerDelegate , UINavigationControllerDelegate   {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    print("didFinishPickingMediaWithInfo")
    picker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
    //magePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
    
        if let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] {
        print("image created")
      tempImage = image as? UIImage
     
       // self.createPost(hasImage: true)
        dismiss(animated: true, completion:{
            self.createPost(hasImage:true)
        })
    }
  }
}


