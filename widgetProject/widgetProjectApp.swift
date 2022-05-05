//
//  widgetProjectApp.swift
//  widgetProject
//
//  Created by Kim Insub on 2022/05/04.
//

import SwiftUI

@main
struct widgetProjectApp: App {
    var network = Network()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(network)
                .environment(\.colorScheme, .light)
        }
    }
}
