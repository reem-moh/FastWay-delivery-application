//
//  HomeMemberView.swift
//  FastWay
//
//  Created by Ghaida . on 21/06/1442 AH.
//

import SwiftUI

struct HomeMemberView: View {
    
    
    @Binding var showSendOrder: Bool
        @Binding var showPickup: Bool
    
    

      //  @Binding var pro: Bool
    
    var body: some View {
        ZStack{
                 VStack{
                     //background image
                     Image("Rectangle 49").ignoresSafeArea()
                     Spacer()
                     
                     
                 }
            
            VStack{
                //background image
                Image("Rectangle 49").ignoresSafeArea()
                Spacer()
            }
            VStack{
                //white rectangle
                Spacer(minLength: 100)
                Image("Rectangle 48").resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            }
            
            
                 VStack{
                    /* transparent-log-out-icon-5d6b36311cbea9 2 */

                 

                    
                   Button(action: {
                      self.showPickup.toggle()
                       
                   }) {
                    
                    //logo, text feilds and buttons
                    Image("addNewOrder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 180)
                        .clipped().offset(x:0 ,y:30)
                   }
                
                    
                    
                    
                    
                    
                   Button(action: {
                      self.showPickup.toggle()
                       
                   }) {
                     Image("current")
                         .resizable()
                         .aspectRatio(contentMode: .fill)
                         .frame(width: 300, height: 180)
                         .clipped().offset(x:0 ,y:50)
                     
                   }
                    
                    
                    
                    
                   Button(action: {
                      self.showPickup.toggle()
                       
                   }) {
                     
                     Image("History")
                         .resizable()
                         .aspectRatio(contentMode: .fill)
                         .frame(width: 300, height: 180)
                         .clipped() .offset(x:0 ,y:65)
                     
                   }
                    
                    
                 
                     HStack(){
                         
                        

                         Image("home")
                             .resizable()
                             .aspectRatio(contentMode: .fill)
                             .frame(width: 133, height: 69)
                           .clipped().offset(x:-66 ,y:84)
                         
                         
                         Image("cart")
                             .resizable()
                             .aspectRatio(contentMode: .fill)
                             .frame(width: 24, height: 24)
                             .clipped().offset(x:-20 ,y:84)
                         
                         Image("user")
                             .resizable()
                             .aspectRatio(contentMode: .fill)
                             .frame(width: 69, height: 69)
                            .clipped() .offset(x:40 ,y:84)
                         
                     }
                 }
                 
             }
                 
         }
     }
     

