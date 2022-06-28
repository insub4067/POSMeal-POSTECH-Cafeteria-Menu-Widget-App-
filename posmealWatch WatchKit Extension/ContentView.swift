//
//  ContentView.swift
//  posmealWatch WatchKit Extension
//
//  Created by Park Sungmin on 2022/06/28.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var network: Network
    
    
    var body: some View {
        TabView{
            WatchMenuView(date: "today", menuIndex: 0)
            WatchMenuView(date: "tomorrow", menuIndex: 1)
            WatchMenuView(date: "dayAfterTomorrow", menuIndex: 2)
        }
        
        .onAppear{
            network.getMenus(of: "today")
            network.getMenus(of: "tomorrow")
            network.getMenus(of: "dayAfterTomorrow")
//                UserDefaults(suiteName: "group.com.kim.widgetProject")!.set(self.selectedMeal, forKey: "SELECTEDMEAL")
        }
    }
}

