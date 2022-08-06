//
//  _______App.swift
//  POSmealWatch WatchKit Extension
//
//  Created by Park Sungmin on 2022/08/06.
//

import SwiftUI

@main
struct _______App: App {
    var network = Network()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(network)
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
