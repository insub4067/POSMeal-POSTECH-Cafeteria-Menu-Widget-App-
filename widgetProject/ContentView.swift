//
//  ContentView.swift
//  widgetProject
//
//  Created by Kim Insub on 2022/05/04.
//

import SwiftUI

struct ContentView: View {
    //Define
    @EnvironmentObject var network: Network
    @AppStorage("isFirstLaunching") var isFirstLaunching: Bool = true
    @State private var isLoading = false
    @State private var showSheet = false
    @State private var selectedMeal = "LUNCH"

    var body: some View {
        
        //Date Define
        let date = network.currentDate()
        let month = date["month"]!
        let day = date["day"]!
        let weekday = date["weekday"]!
        
        let myDict = [
            "BREAKFAST_A" : "조식",
            "BREAKFAST_B" : "간단식",
            "LUNCH" : "중식",
            "DINNER" : "석식",
            "STAFF" : "위즈덤",
            "INTERNATIONAL" : "더 블루힐"
        ]
        
        let scheduleDict = [
            "BREAKFAST_A" : "07:30 ~ 09:00",
            "BREAKFAST_B" : "07:30 ~ 09:00",
            "LUNCH" : "11:30 ~ 13:30",
            "DINNER" : "17:30 ~ 19:00",
            "STAFF" : "11:50 ~ 13:00",
            "INTERNATIONAL" : "11:30 ~ 13:30"
        ]
        
        NavigationView {
            VStack (alignment: .center){
                //Menus
                ScrollView {
                    VStack(spacing: 17) {
                        ForEach(network.menus) { menu in
                            //CARD
                            VStack(alignment: .leading) {
                                //Title
                                HStack{
                                    //Name
                                    Text(myDict[menu.type]!)
                                        .bold()
                                    Spacer()
                                    //Time
                                    Text(scheduleDict[menu.type]!)
                                        .font(.system(size: 12))
                                        .foregroundColor(Color(red: 105/255, green: 105/255, blue: 105/255))
                                        .padding(.vertical, 3)
                                        .padding(.horizontal, 5)
                                        .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                                        .cornerRadius(20)
                                }
                                //Food
                                VStack(alignment: .leading, spacing: 6) {
                                    ForEach(menu.foods) { food in
                                        let check = food.isMain == true ? "*" : ""
                                        Text(food.name_kor + check)
                                            .font(.system(size: 15))
                                    }
                                }
                            }
                            .frame(width: 300, alignment: .leading)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                //PAGE LOADING VIEW
                if isLoading{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(3)
                }
            }
            .background(Color(red: 242/255, green: 242/255, blue: 246/255))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItemGroup(placement: ToolbarItemPlacement.bottomBar){
                    //REFRESH BUTTON
                    Button{
                        self.network.getMenus()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                    //WIDGET CONFIG BUTTON
                    Button{
                        self.showSheet = true
                    } label: {
                        Text("위젯설정")
                    }
                }
                ToolbarItem(placement: ToolbarItemPlacement.principal){
                    //Title
                    Text("\(month)월 \(day)일 \(weekday)")
                        .font(.title)
                        .bold()
                        .padding(.vertical, 10)
                }
            }
            //WIDGET CONFIG : SELECT MEAL
            .confirmationDialog("위젯에 보일 정보를 선택하세요", isPresented: self.$showSheet, titleVisibility: .visible){
                Button("조식"){
                    self.selectedMeal = "BREAKFAST_A"
                    UserDefaults(suiteName: "group.com.kim.widgetProject")!.set(self.selectedMeal, forKey: "SELECTEDMEAL")
                }
                Button("간단식"){
                    self.selectedMeal = "BREAKFAST_B"
                    UserDefaults(suiteName: "group.com.kim.widgetProject")!.set(self.selectedMeal, forKey: "SELECTEDMEAL")
                }
                Button("중식"){
                    self.selectedMeal = "LUNCH"
                    UserDefaults(suiteName: "group.com.kim.widgetProject")!.set(self.selectedMeal, forKey: "SELECTEDMEAL")
                }
                Button("식식"){
                    self.selectedMeal = "DINNER"
                    UserDefaults(suiteName: "group.com.kim.widgetProject")!.set(self.selectedMeal, forKey: "SELECTEDMEAL")
                }
                Button("중식"){
                    self.selectedMeal = "STAFF"
                    UserDefaults(suiteName: "group.com.kim.widgetProject")!.set(self.selectedMeal, forKey: "SELECTEDMEAL")
                }
                Button("더 블루힐"){
                    self.selectedMeal = "INTERNATIONAL"
                    UserDefaults(suiteName: "group.com.kim.widgetProject")!.set(self.selectedMeal, forKey: "SELECTEDMEAL")
                }
            }
            
        }
        .onAppear{
            UserDefaults(suiteName: "group.com.kim.widgetProject")!.set(self.selectedMeal, forKey: "SELECTEDMEAL")
            isLoading = true
            network.getMenus()
            isLoading = false
        }
        .fullScreenCover(isPresented: self.$isFirstLaunching){
            OnBoardingTabView(isFirstLaunching: self.$isFirstLaunching)
        }
    }
}
