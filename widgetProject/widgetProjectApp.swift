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
    @StateObject var network = Network.shared

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(network)
        }
    }
}
