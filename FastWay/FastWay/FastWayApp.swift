//
//  FastWayApp.swift
//  FastWay
//
//  Created by taif.m on 2/2/21.
//

import SwiftUI
import Firebase
@main
struct FastWayApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool{
        print("setting")
        FirebaseApp.configure()
        return true
    }
}
