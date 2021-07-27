//
//  Little_Chicago_SF_AppApp.swift
//  Little Chicago SF App
//
//  Created by mr_robot on 7/10/21.
//

import SwiftUI
import Firebase

@main
struct Little_Chicago_SF_AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// Intitaliziing Firebase...

class AppDelegate: NSObject,UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
}
