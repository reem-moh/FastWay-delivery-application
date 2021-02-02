//
//  ContentView.swift
//  FastWay

import SwiftUI
import Firebase
import FirebaseFirestore

struct ContentView: View {
    var body: some View {
        ZStack{
            //Image(uiImage: #imageLiteral(resourceName: "whiteBackground")).edgesIgnoringSafeArea(.all).offset(y:-100)
            VStack(alignment: .center) {
                //logo
                Image(uiImage: #imageLiteral(resourceName: "FastWay")).padding()
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}


    


