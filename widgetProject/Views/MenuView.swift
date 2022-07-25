//
//  TodayMenuView.swift
//  포스밀
//
//  Created by Kim Insub on 2022/05/07.
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

    var body: some View {
        let date = network.getDate(of: date)
        
        let month = date["month"]!
        let day = date["day"]!
        let weekday = date["weekday"]!
        
        let menusList = [network.todaysMenus, network.tomrrowsMenus, network.dayAfterTomorrowMenus]
                
        VStack {
            Text("\(month)월 \(day)일 \(weekday)")
                .font(.title)
                .bold()
                .padding(.vertical, 10)
            ScrollView {
                VStack(spacing: 17) {
                    ForEach(menusList[menuIndex]) { menu in
                        //CARD
                        VStack(alignment: .leading) {
                            //Title
                            HStack{
                                //Name
                                Text(mealNameDict[menu.type]!)
                                    .bold()
                                Spacer()
                                //Time
                                Text(scheduleDict[menu.type]!)
                                    .font(.system(size: 12))
                                    .foregroundColor(Color.timeForegroundColor)
                                    .padding(.vertical, 3)
                                    .padding(.horizontal, 5)
                                    .background(Color.timeBackgroundColor)
                                    .cornerRadius(20)
                            }
                            //Food
                            VStack(alignment: .leading, spacing: 6) {
                                ForEach(menu.foods) { food in
                                    let check = food.isMain == true ? "*" : ""
                                    Text(food.name_kor + check)
                                        .font(.system(size: 15))
                                        .foregroundColor(Color.foodForeground)
                                }
                            }
                        }
                        .frame(width: 300, alignment: .leading)
                        .padding()
                        .background(Color.cardBackground)
                        .cornerRadius(10)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}
