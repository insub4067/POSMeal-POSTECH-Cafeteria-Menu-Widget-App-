//
//  TomorrowMenuView.swift
//  포스밀
//
//  Created by Kim Insub on 2022/05/07.
//

import SwiftUI

struct TomorrowMenuView: View {
    @EnvironmentObject var network: Network
    
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
        let date = network.getDate(of: "tomorrow")
        let month = date["month"]!
        let day = date["day"]!
        let weekday = date["weekday"]!
        
    
        VStack {
            Text("\(month)월 \(day)일 \(weekday)")
                .font(.title)
                .bold()
                .padding(.vertical, 10)
            ScrollView {
                VStack(spacing: 17) {
                    ForEach(network.tomrrowsMenus) { menu in
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
        }
    }
}

struct TomorrowMenuView_Previews: PreviewProvider {
    static var previews: some View {
        TomorrowMenuView()
    }
}
