//
//  PostListView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI
 
struct PostListView: View {
  var postHandler  = PostViewModel()
    @State var modalIsPresented = false
    
   var body: some View {
   
    List{
        VStack(alignment: .leading){
            HStack(alignment: .center){
            
            Image("mascot_swift-badge").resizable().aspectRatio(contentMode: .fit)
                .frame(width: 50.0, height: 50.0, alignment: .leading)
                Text("Home").bold().font(.largeTitle).frame(maxWidth: .infinity)
                 Text("Filler")
                 .foregroundColor(Color.clear)
            
          }//HStack
              Button(action:{
                  self.modalIsPresented = true
                  
                }) {
                Text("Add Posts").foregroundColor(.blue)
                 }//Button
         }//VStack
        
        ForEach(postHandler.posts){ item in
           
             PostView(post: item
               )
        }//foreach
    }//List
        
    .sheet(isPresented: $modalIsPresented) {
        NewPostView(postHandler: self.postHandler)
    }
   
  }//body
    
}//struct PostListView

struct PostListView_Previews: PreviewProvider {
  static var previews: some View {
    PostListView()
  }
}
