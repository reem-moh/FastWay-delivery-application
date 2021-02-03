//
//  ContentView.swift
//  FastWay

import SwiftUI


struct ContentView: View {
    @State var showSign = false
    @State var showHome = false
    
    var body: some View {
       
        NavigationView{
            ZStack{
                    NavigationLink(
                        destination: SignUPView(show: self.$showSign,showHome: self.$showHome),
                    isActive: self.$showSign ){
                        Text("")
                    }
                    .hidden()
                    
                
                LoginView(showSign: self.$showSign,showHome: self.$showHome)
                
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


    


