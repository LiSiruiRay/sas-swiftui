//
//  swiftui_with_firebaseApp.swift
//  swiftui-with-firebase
//
//  Created by Ray on 7/9/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    Auth.auth().useEmulator(withHost:"localhost", port:4000)
    return true
  }
}

@main
struct swiftui_with_firebaseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
      WindowGroup {
        NavigationView {
            ContentView()
                .environmentObject(AuthenticationViewModel())
            Text("Hello")
        }
      }
    }
}
