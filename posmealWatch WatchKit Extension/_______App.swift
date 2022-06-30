//
//  _______App.swift
//  posmealWatch WatchKit Extension
//
//  Created by Park Sungmin on 2022/06/28.
//

import SwiftUI
import WatchKit

@main
struct _______App: App {
    
    @WKExtensionDelegateAdaptor(ExtensionDelegate.self) private var extensionDelegate

    @StateObject private var network = Network.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(network)
            }
        }
    }
}
