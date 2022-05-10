//
//  widgetProjectApp.swift
//  widgetProject
//
//  Created by Kim Insub on 2022/05/04.
//

import SwiftUI
import Firebase

@main
struct widgetProjectApp: App {
    var network = Network()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(network)
        }
    }
}
