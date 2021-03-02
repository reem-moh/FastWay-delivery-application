//
//  MotherView.swift
//  FastWay
//
//  Created by Reem on 06/02/2021.
//

import SwiftUI

struct MotherView: View {
    @StateObject var courierOrderModel = CarouselViewModel()
    @StateObject var CurrentMModel = CurrentCarouselMViewModel()
    @StateObject var CurrentCModel = CurrentCarouselCViewModel()
   // @StateObject var OfferModel = OfferCarousel()
    @StateObject var viewRouter: ViewRouter
    @Namespace var animation
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
            DROPOFFlocationView(viewRouter : viewRouter)
        case .SendOrder :
            SendOrderIView(viewRouter : viewRouter)
        case .ViewProfileM :
            ViewMemberProfile(viewRouter : viewRouter)
        case .CurrentOrder :
            CurrentOrderView(viewRouter : viewRouter) .environmentObject(CurrentMModel)
        case .HistoryView :
            HistoryView(viewRouter : viewRouter)
        case .DeliverOrder :
            DeliverOrderView(viewRouter : viewRouter) .environmentObject(courierOrderModel)
        case .ViewProfileC:
            ViewCourierProfile(viewRouter: viewRouter)
        case .AboutUs:
            AboutUs(viewRouter: viewRouter)//
        case .CurrentOrderCourier:
            CurrentOrderCourierView(viewRouter: viewRouter).environmentObject(CurrentCModel)
        case .HistoryCourierView:
            HistoryCourierView(viewRouter: viewRouter)
        case .DetailedOrderOffer:
            DetailedOrderOffer(viewRouter: viewRouter, animation: animation)
       /* case .CurrentOrderViewDetailsCourier:
                    CurrentOrderViewDetailsCourier(viewRouter: viewRouter, animation: animation)*/
        //case .offers:
          //  Offers(viewRouter: viewRouter) .environmentObject(OfferModel)
            //Offers(viewRouter: viewRouter, orderID: "", status: "") .environmentObject(OfferModel)
        }
        
    }
    
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView(viewRouter: ViewRouter())//.environmentObject(SessionStore())
    }
}
