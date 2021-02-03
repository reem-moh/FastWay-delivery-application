//
//  ContentView.swift
//  FastWay

import SwiftUI


struct ContentView: View {
    @State var showSign = false
    @State var showReset = false
    
    var body: some View {
       
        NavigationView{
            ZStack{
                    NavigationLink(
                        destination: SignUPView(show: self.$showSign),
                    isActive: self.$showSign ){
                        Text("")
                    }
                    .hidden()
                    
                
                LoginView(showSign: self.$showSign)
                
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


    


