//
//  HistoryView.swift
//  FastWay
//
//  Created by Reem on 06/02/2021.
//

import SwiftUI

struct HistoryView: View {
    
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        Text("Hello, HistoryView!")
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(viewRouter: ViewRouter())
    }
}
