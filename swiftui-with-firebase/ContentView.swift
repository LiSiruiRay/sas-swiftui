//
//  ContentView.swift
//  swiftui-with-firebase
//
//  Created by Ray on 7/9/23.
//

import SwiftUI
import Combine
import FirebaseAnalyticsSwift
import AuthenticationServices
import Firebase
import FirebaseAuth
import FirebaseCore

class appDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Auth.auth().useEmulator(withHost: "localhost", port: 4000)
        return true
    }
}

struct ContentView: View {
    
    var body: some View {
        
        NavigationView {
                    VStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        Text("Hello, world!")
                        Text("This is the first screen")

                        NavigationLink(destination: LogInView()) {
                            Text("Go to Login screen")
                        }
                    }
                }
        .padding()
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
        
    }
}
