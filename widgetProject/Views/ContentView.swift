//
//  ContentView.swift
//  widgetProject
//
//  Created by Kim Insub on 2022/05/04.
//

import SwiftUI
import WidgetKit

struct ContentView: View {

    // Define
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var network: Network
    @AppStorage("isFirstLaunching") var isFirstLaunching: Bool = true
    @State private var showSheet = false
    @State private var selectedMeal = "ONTIME"

    // init
    init(){
        UIPageControl.appearance().currentPageIndicatorTintColor = Color.currentPageIndicatorTintColor
        UIPageControl.appearance().pageIndicatorTintColor = Color.pageIndicatorTintColor
    }

    // body
    var body: some View {
        
        NavigationView {
            TabView{
                MenuView(date: "today", menuIndex: 0)
                MenuView(date: "tomorrow", menuIndex: 1)
                MenuView(date: "dayAfterTomorrow", menuIndex: 2)
            }
            .onAppear{
                // Lock on Portrait Mode
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                AppDelegate.orientationLock = .portrait
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .background(Color.backgroundColor)
            .navigationBarHidden(true)
            .toolbar{
                ToolbarItemGroup(placement: ToolbarItemPlacement.bottomBar){
                    //WIDGET CONFIG BUTTON
                    Button{
                        self.showSheet = true
                    } label: {
                        Text("위젯설정")
                    }
                }
            }
            //WIDGET CONFIG : SELECT MEAL
            .confirmationDialog("위젯에 보일 정보를 선택하세요", isPresented: self.$showSheet, titleVisibility: .visible){
                Button("조식"){
                    self.selectedMeal = "BREAKFAST_A"
                    updateSelectedMeal(meal: selectedMeal)
                }
                Button("간단식"){
                    self.selectedMeal = "BREAKFAST_B"
                    updateSelectedMeal(meal: selectedMeal)

                }
                Button("중식"){
                    self.selectedMeal = "LUNCH"
                    updateSelectedMeal(meal: selectedMeal)

                }
                Button("석식"){
                    self.selectedMeal = "DINNER"
                    updateSelectedMeal(meal: selectedMeal)

                }
                Button("위즈덤"){
                    self.selectedMeal = "STAFF"
                    updateSelectedMeal(meal: selectedMeal)

                }
                Button("더 블루힐"){
                    self.selectedMeal = "INTERNATIONAL"
                    updateSelectedMeal(meal: selectedMeal)

                }
                Button("시간에 맞추기"){
                    self.selectedMeal = "ONTIME"
                    updateSelectedMeal(meal: selectedMeal)

                }
            }
        }
        .onChange(of: scenePhase){
            newPhase in
            if newPhase == .active {
                network.getMenus(of: "today")
                network.getMenus(of: "tomorrow")
                network.getMenus(of: "dayAfterTomorrow")
                updateSelectedMeal(meal: selectedMeal)
            }
        }
        .onAppear{
            network.getMenus(of: "today")
            network.getMenus(of: "tomorrow")
            network.getMenus(of: "dayAfterTomorrow")
            updateSelectedMeal(meal: selectedMeal)
        }
        .fullScreenCover(isPresented: self.$isFirstLaunching){
            OnBoardingTabView(isFirstLaunching: self.$isFirstLaunching)
        }
    }
}

fileprivate func updateSelectedMeal(meal: String) {
    UserDefaults(suiteName: "group.com.kim.widgetProject")?.set(meal, forKey: "SELECTEDMEAL")
    WidgetCenter.shared.reloadTimelines(ofKind: "com.kim.widgetProject.myWidget")
}
