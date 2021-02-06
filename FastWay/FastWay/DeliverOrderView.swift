//
//  DeliverOrderView.swift
//  FastWay
//
//  Created by Reem on 06/02/2021.
//

import SwiftUI

struct DeliverOrderView: View {
    
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DeliverOrderView_Previews: PreviewProvider {
    static var previews: some View {
        DeliverOrderView(viewRouter: ViewRouter())
    }
}
