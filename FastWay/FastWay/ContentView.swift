//
//  ContentView.swift
//  FastWay

import SwiftUI


struct ContentView: View {
    @State var showSign = false
    @State var showHomeCourier = false
    @State var showHomeMember = false
    
    var body: some View {
        
        NavigationView{
            ZStack{
                NavigationLink(
                    destination: SignUPView(show: self.$showSign,showHomeCourier: self.$showHomeCourier,showHomeMember: self.$showHomeMember ),
                    isActive: self.$showSign ){
                    Text("")
                }
                .hidden()
                NavigationLink(
                    destination: HomeCourierView(),
                    isActive: self.$showHomeCourier ){
                    Text("")
                }
                .hidden()
                
                
                LoginView(showSign: self.$showSign,showHomeCourier: self.$showHomeCourier, showHomeMember: self.$showHomeMember )
                
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





