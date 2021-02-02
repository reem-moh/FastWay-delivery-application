//
//  ContentView.swift
//  FastWay

import SwiftUI
import Firebase
import FirebaseFirestore

struct ContentView: View {
    @State var show = false
    var body: some View {
       
        NavigationView{
            ZStack{
                    NavigationLink(
                        destination: SignUPView(show: self.$show),
                    isActive: self.$show ){
                        Text("")
                    }
                    .hidden()
                
                LoginView(show: self.$show)
                
            }.navigationBarTitle("")
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


    


