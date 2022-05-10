//
//  TodayMenuView.swift
//  포스밀
//
//  Created by Kim Insub on 2022/05/07.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var network: Network
    
    let date: String
    let menuIndex: Int
    
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

    var body: some View {
        let date = network.getDate(of: date)
        
        let month = date["month"]!
        let day = date["day"]!
        let weekday = date["weekday"]!
        
        let darkModeForeground = Color(red: 171/255, green: 171/255, blue: 171/255)
        let darkModeBackgroundColor = Color(red: 28/255, green: 28/255, blue: 30/255)
        let timeDarkModeBackground = Color(red: 60/255, green: 60/255, blue: 60/255)
        let timeLightModeBackground = Color(red: 240/255, green: 240/255, blue: 240/255)
        let timeLightModeForeground = Color(red: 105/255, green: 105/255, blue: 105/255)
        
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
                                Text(myDict[menu.type]!)
                                    .bold()
                                Spacer()
                                //Time
                                Text(scheduleDict[menu.type]!)
                                    .font(.system(size: 12))
                                    .foregroundColor(colorScheme == .dark ? darkModeForeground : timeLightModeForeground)
                                    .padding(.vertical, 3)
                                    .padding(.horizontal, 5)
                                    .background(colorScheme == .dark ? timeDarkModeBackground : timeLightModeBackground)
                                    .cornerRadius(20)
                            }
                            //Food
                            VStack(alignment: .leading, spacing: 6) {
                                ForEach(menu.foods) { food in
                                    let check = food.isMain == true ? "*" : ""
                                    Text(food.name_kor + check)
                                        .font(.system(size: 15))
                                        .foregroundColor(colorScheme == .dark ? darkModeForeground : Color.black)
                                }
                            }
                        }
                        .frame(width: 300, alignment: .leading)
                        .padding()
                        .background(colorScheme == .dark ? darkModeBackgroundColor : Color.white)
                        .cornerRadius(10)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}
