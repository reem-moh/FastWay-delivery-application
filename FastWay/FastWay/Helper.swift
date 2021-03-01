//
//  Helper.swift
//  FastWay
//
//  Created by Reem on 06/02/2021.
//

import Foundation

enum Page{
    case LogIn
    case SignUp
    case HomePageM
    case HomePageC
    case AddNewOrder
    case DROPOFFlocation
    case SendOrder
    case ViewProfileM
    case ViewProfileC
    case AboutUs
    case CurrentOrder
    case CurrentOrderCourier
    case HistoryView
    case HistoryCourierView
    case DeliverOrder
    case DetailedOrderOffer
    case offers
}
// to identify each notificatio or confirmation message when transitioning from one
// view to the other
enum NotificationType {
    case None
    case LogIn
    case SignUp
    case SendOrder
    case SendOffer
    case CancelOrder
}


