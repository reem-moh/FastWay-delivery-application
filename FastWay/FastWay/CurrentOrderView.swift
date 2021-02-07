//
//  CurrentOrderView.swift
//  FastWay
//
//  Created by Reem on 06/02/2021.
//

import SwiftUI

struct CurrentOrderView: View {
    
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        
        
          ZStack{
              
              
              VStack{
                  //background image
                  Image("Rectangle 49").ignoresSafeArea()
                  Spacer()
              }
        VStack{
            
            
            
       
            //arrow_back image
            
           Button(action: {
            viewRouter.currentPage = .HomePageM
               
           }) {
             Image("arrow_back")
                 .resizable()
                 .aspectRatio(contentMode: .fill)
                 .frame(width: 30, height: 30)
               .clipped()
           }.position(x:30 ,y:70)
        
            
            //white rectangle
            Spacer(minLength: 100)
            Image("Rectangle 48").resizable().aspectRatio(contentMode: .fill)
        }
        Text("Hello, CurrentOrderView!")
    }
    }}

struct CurrentOrderView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentOrderView(viewRouter: ViewRouter())
    }
}
