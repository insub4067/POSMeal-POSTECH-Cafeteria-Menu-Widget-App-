//
//  ContentView.swift
//  POSmealWatch WatchKit Extension
//
//  Created by Park Sungmin on 2022/08/06.
//

import SwiftUI

struct ContentView: View {
    
    // Define
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var network: Network
    @AppStorage("isFirstLaunching") var isFirstLaunching: Bool = true
    @State private var showSheet = false
    @State private var selectedMeal = "ONTIME"
    
    // body
    var body: some View {
        
        TabView{
            MenuView(date: "today", menuIndex: 0)
            MenuView(date: "tomorrow", menuIndex: 1)
            MenuView(date: "dayAfterTomorrow", menuIndex: 2)
            SettingView()
        }
        .onAppear{
            network.getMenus(of: "today")
            network.getMenus(of: "tomorrow")
            network.getMenus(of: "dayAfterTomorrow")
            updateSelectedMeal(meal: selectedMeal)
            
        }
        .background(Color.black)

    }
}

fileprivate func updateSelectedMeal(meal: String) {
    UserDefaults(suiteName: "group.com.kim.widgetProject")?.set(meal, forKey: "SELECTEDMEAL")
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
