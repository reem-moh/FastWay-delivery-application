//
//  ContentView.swift
//  FastWay

import SwiftUI
import Firebase
import FirebaseFirestore

struct ContentView: View {
    @State var showSign = false
    @State var showHomeCourier = false
    @State var showHomeMember = false
    @State var check = false
    
    
    var body: some View {
        
        NavigationView{
            ZStack{
                
                //SignUP
                NavigationLink(
                    destination: SignUPView(show: self.$showSign,showHomeCourier: self.$showHomeCourier,showHomeMember: self.$showHomeMember ),
                    isActive: self.$showSign ){
                    Text("")
                }
                .hidden()
                
                //HomeCourier view
               NavigationLink(
                    destination: HomeCourierView(),
                    isActive: self.$showHomeCourier ){
                    Text("")
                }
                .hidden()
                
                //HomeMember view
                NavigationLink(
                    destination: HomeMemberView(),
                    isActive: self.$showHomeMember ){
                    Text("")
                }
                .hidden()
                
                let signedUser = Auth.auth().currentUser
                
                if signedUser != nil {
                    ContentViewHome()
                }else {
                    //The firstPage
                    LoginView(showSign: self.$showSign,showHomeCourier: self.$showHomeCourier, showHomeMember: self.$showHomeMember ).navigationTitle("LogIn")
                }
                
   
                
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





