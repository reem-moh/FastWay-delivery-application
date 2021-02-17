//
//  MotherView.swift
//  FastWay
//
//  Created by Reem on 06/02/2021.
//

import SwiftUI

struct MotherView: View {
    @StateObject var homeModel = CarouselViewModel()
    @StateObject var viewRouter: ViewRouter

    var body: some View {

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
                    SendOrderIView(viewRouter : viewRouter)
                 //   DROPOFFlocationView(viewRouter : viewRouter)
                case .SendOrder :
                    SendOrderIView(viewRouter : viewRouter)
                case .ViewProfileM :
                    ViewMemberProfile(viewRouter : viewRouter)
                case .CurrentOrder :
                    CurrentOrderView(viewRouter : viewRouter)
                case .HistoryView :
                    HistoryView(viewRouter : viewRouter)
                case .DeliverOrder :
                    DeliverOrderView(viewRouter : viewRouter) .environmentObject(homeModel)
                case .ViewProfileC:
                    ViewCourierProfile(viewRouter: viewRouter)
                case .AboutUs:
                    AboutUs(viewRouter: viewRouter)//
                //case .DetailsDeliver:
                   // DetailedOrderOffer(viewRouter: ViewRouter())
            }
       
    }
    
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView(viewRouter: ViewRouter())//.environmentObject(SessionStore())
    }
}
