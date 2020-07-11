//
//  PostView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct PostView: View {
 //@Binding let post: MediaPost
   let post: MediaPost
    func formatDate(date:Date)->String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = "d MMM y, HH:mm"
        return  formatter.string(from:date)
        
    }
  //postView is defined here
  var body: some View {
    VStack(alignment: .leading){
        HStack(alignment: .top) {
   
            Image("mascot_swift-badge").resizable().aspectRatio(contentMode: .fit)
                .frame(width: 50.0, height: 50.0, alignment: .leading)
        
            VStack(alignment: .leading){
                Text(post.userName)
        
                Text(formatDate(date: post.timestamp))
            }//VStack
        }//HStack
        if post.textBody != nil{
            Text(post.textBody!)
        }
    
    HStack(alignment: .center){
        Spacer()
        if post.uiImage != nil {
            Image(uiImage: post.uiImage!)
            .resizable()
            .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100, alignment:.center)
            //.frame(width: 30, height: 30, alignment: .center)
            Spacer()
            
            
        } //if
    } //HStack
     }//body
    
    
        
}


struct PostView_Previews: PreviewProvider {
  static var previews: some View {
    PostView(post: MediaPost(textBody: "Went to the Aquarium today :]",
      userName: "Audrey", timestamp: Date(timeIntervalSinceNow: -9876),
      uiImage: UIImage(named: "octopus")))
  }
}

}
