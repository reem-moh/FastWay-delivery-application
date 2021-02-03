//
//  ContentView.swift
//  FastWay
//
//  Created by taif.m on 2/2/21.
//

import SwiftUI
//import Firebase
//import FirebaseFirestore

struct ContentView: View {
    @State var showSign = false
    @State var showHomeCourier = false
    @State var showHomeMember = false
    
    var body: some View {
       AddNewOrderView()
        NavigationView{
            ZStack{
                    NavigationLink(destination: DROPOFFlocationView()){
                        Text("")
                    }
                    .hidden()
                   /* NavigationLink(
                        destination: HomeCourierView(),
                    isActive: self.$showHomeCourier ){
                        Text("")
                    }
                    .hidden()*/
                
     //   LoginView(showSign: self.$showSign,showHomeCourier: self.$showHomeCourier, showHomeMember: //self.$showHomeMember )
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
        }//end of NavigationView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}


