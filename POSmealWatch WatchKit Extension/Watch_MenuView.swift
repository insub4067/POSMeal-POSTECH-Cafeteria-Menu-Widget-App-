//
//  MenuView.swift
//  POSmealWatch WatchKit Extension
//
//  Created by Park Sungmin on 2022/08/06.
//

import SwiftUI

struct MenuView: View {
    
    // environment
    @EnvironmentObject var network: Network
    
    // param
    let date: String
    let menuIndex: Int
    
    let mealNameDict = TimeManager().mealNameDict
    let scheduleDict = TimeManager().scheduleMediumSize
    
    @State var showMealList: [Bool] = [true, true, true, true, true, true, true]
    
    var body: some View {
        let date = network.getDate(of: date)
        
        let month = date["month"]!
        let day = date["day"]!
        let weekday = date["weekday"]!
        
        let menusList = [network.todaysMenus, network.tomrrowsMenus, network.dayAfterTomorrowMenus]
        
        VStack {
            ScrollView {
                VStack(spacing: 17) {
                    ForEach(menusList[menuIndex].indices, id: \.self) { idx in
                        
                        if showMealList[idx] {
                            //CARD
                            VStack(alignment: .leading) {
                                //Title
                                HStack{
                                    //Name
                                    Text(mealNameDict[menusList[menuIndex][idx].type]!)
                                        .bold()
                                    Spacer()
                                    //Time
                                    Text(scheduleDict[menusList[menuIndex][idx].type]!)
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.timeForegroundColor)
                                        .padding(.vertical, 3)
                                        .padding(.horizontal, 5)
                                        .background(Color.timeBackgroundColor)
                                        .cornerRadius(20)
                                }
                                //Food
                                VStack(alignment: .leading, spacing: 6) {
                                    ForEach(menusList[menuIndex][idx].foods) { food in
                                        let check = food.isMain == true ? "*" : ""
                                        Text(food.name_kor + check)
                                            .font(.system(size: 15))
                                            .foregroundColor(Color.foodForeground)
                                    }
                                }
                            }
                            .frame(alignment: .leading)
                            .padding()
                            .background(Color.cardBackground)
                            .cornerRadius(10)
                        }
                    }
                }
            }
        }
        .onAppear {
            self.showMealList = (UserDefaults.standard.array(forKey: "ShowMealList") ?? [true, true, true, true, true, true, true]) as! [Bool]
        }
        .navigationTitle("\(month)월 \(day)일 \(weekday)")
    }
}
