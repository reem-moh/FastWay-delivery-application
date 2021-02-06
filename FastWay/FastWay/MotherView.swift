//
//  MotherView.swift
//  FastWay
//
//  Created by Reem on 06/02/2021.
//

import SwiftUI

struct MotherView: View {
    
    @StateObject var viewRouter: ViewRouter
   // @State var member: Member
    //@EnvironmentObject var session: SessionStore
    
    var body: some View {
        
        //Group {
            
            /*if (session.session != nil) {
                    viewRouter.currentPage = .HomePageM
            } else {
                viewRouter.currentPage = .LogIn
            }*/
           
            switch viewRouter.currentPage {
                case .LogIn :
                    LoginView(viewRouter : viewRouter)
                case .SignUp:
                    SignUPView(viewRouter : viewRouter)
                case .HomePageM :
                    HomeMemberView(viewRouter : viewRouter)
                case .HomePageC :
                    HomeCourierView(viewRouter : viewRouter)
                case .AddNewOrder :
                    AddNewOrderView(viewRouter : viewRouter)
                case .DROPOFFlocation :
                    DROPOFFlocationView(viewRouter : viewRouter)
                case .SendOrder :
                    SendOrderIView(viewRouter : viewRouter)
                case .ViewProfile :
                    ViewProfile(viewRouter : viewRouter)
                case .CurrentOrder :
                    CurrentOrderView(viewRouter : viewRouter)
                case .HistoryView :
                    HistoryView(viewRouter : viewRouter)
                case .DeliverOrder :
                    DeliverOrderView(viewRouter : viewRouter)
            }
       // }.onAppear(perform: getUser)
       
    }
    
    
    /*func getUser(){
        session.listen()
    }*/
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView(viewRouter: ViewRouter())//.environmentObject(SessionStore())
    }
}
