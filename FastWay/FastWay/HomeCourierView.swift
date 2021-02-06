//
//  HomeCourierView.swift
//  FastWay
//
//  Created by Ghaida . on 21/06/1442 AH.
//

import SwiftUI

struct HomeCourierView: View {
    
    
    @StateObject var viewRouter: ViewRouter
    
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
                    viewRouter.currentPage = .HomePageM
                   }) {
                    
                    //logo, text feilds and buttons
                    Image("addNewOrder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 180)
                        .clipped().offset(x:0 ,y:60)
                   }
                
                    
                    
                    
                    
                    
                   Button(action: {
                    viewRouter.currentPage = .CurrentOrder
                       
                   }) {
                     Image("current")
                         .resizable()
                         .aspectRatio(contentMode: .fill)
                         .frame(width: 300, height: 180)
                         .clipped().offset(x:0 ,y:70)
                     
                   }
                    
                    
                    
                    
                   Button(action: {
                    viewRouter.currentPage = .HistoryView
                       
                   }) {
                     
                     Image("HistoryCourier")
                         .resizable()
                         .aspectRatio(contentMode: .fill)
                         .frame(width: 300, height: 180)
                         .clipped() .offset(x:0 ,y:80)
                     
                   }
                    
                    
                 
                     HStack(){
                         
                        
                        
                       Button(action: {
                        viewRouter.currentPage = .HomePageC
                           
                       }) {
                         Image("home")
                             .resizable()
                             .aspectRatio(contentMode: .fill)
                             .frame(width: 30, height: 30)
                           .clipped().offset(x:-50 ,y:84)
                       }
                        
                        
                       Button(action: {
                        viewRouter.currentPage = .HistoryView
                           
                       }) {
                         
                         Image("cart")
                             .resizable()
                             .aspectRatio(contentMode: .fill)
                             .frame(width: 35, height: 35)
                             .clipped().offset(x:20 ,y:84)
                       }
                        
        
                        
                       Button(action: {
                        viewRouter.currentPage = .ViewProfile
                           
                       }) {
                         Image("user")
                             .resizable()
                             .aspectRatio(contentMode: .fill)
                             .frame(width: 90, height: 90)
                            .clipped() .offset(x:80 ,y:84)
                       }
                     }
                 }
                 
             }
                 
         }
     }
     
struct HomeCourierView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeCourierView(viewRouter: ViewRouter())
        }
    }
}
