//
//  FastWayApp.swift
//  FastWay

import SwiftUI
import Firebase

@main
struct FastWayApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            MotherView(viewRouter: viewRouter)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool{
        print("configurate firebase")
        FirebaseApp.configure()
        return true
    }
}
