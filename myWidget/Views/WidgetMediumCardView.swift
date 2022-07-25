//
//  SwiftUIView.swift
//  포스밀
//
//  Created by Kim Insub on 2022/07/23.
//

import SwiftUI
import WidgetKit

struct WidgetMediumCardView: View {

    @State var LUNCH_FOODS: [String]? = []
    @State var DINNER_FOODS: [String]? = []

//    let scheduleDict: [String:String]
//    let mealNameDict: [String:String]

    let scheduleDict = TimeManager().schedule
    let mealNameDict = TimeManager().mealNameDict

    var body: some View {

        HStack{
            lunchMenuViewBuilder()
            Divider()
                .padding(.vertical)
            dinnerMenuViewBuilder()
        }
        .onAppear{
            self.LUNCH_FOODS = []
            self.LUNCH_FOODS = UserDefaults(suiteName: "group.com.kim.widgetProject")?.stringArray(forKey: "LUNCH") as? [String]

            self.DINNER_FOODS = []
            self.DINNER_FOODS = UserDefaults(suiteName: "group.com.kim.widgetProject")?.stringArray(forKey: "DINNER") as? [String]
        }
        .background(Color.cardBackground)

    }

    @ViewBuilder func lunchMenuViewBuilder() -> some View {

        VStack(alignment: .leading){
            //Title
            HStack{
                //Title
                Text("\(mealNameDict["LUNCH"]!)")
                    .bold()
                Spacer()
                //Time
                Text(scheduleDict["LUNCH"]!)
                    .font(.system(size:12))
                    .foregroundColor(Color.timeForegroundColor)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 10)
                    .background(Color.timeBackgroundColor)
                    .cornerRadius(10)
            }

            //Contents
            VStack(alignment: .leading, spacing: 2){
                if LUNCH_FOODS != nil{
                    ForEach(LUNCH_FOODS!.indices, id: \.self){
                        foodIndex in
                        if foodIndex < 4 {
                            Text(LUNCH_FOODS![foodIndex])
                                .font(.system(size: 14))
                                .foregroundColor(Color.foodForeground)
                        }
                        else if foodIndex == 4 {
                            Text(LUNCH_FOODS![foodIndex] + (LUNCH_FOODS!.count > 5 ? " 외 \(LUNCH_FOODS!.count - 5)개" : ""))
                                .font(.system(size: 14))
                                .foregroundColor(Color.foodForeground)
                        }
                    }
                }
                else if LUNCH_FOODS == nil {
                    Text("위젯 제거 후 다시 추가해주세요.")
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }

    @ViewBuilder func dinnerMenuViewBuilder() -> some View {
        VStack(alignment: .leading){
            //Title
            HStack{
                //Title
                Text("\(mealNameDict["DINNER"]!)")
                    .bold()
                Spacer()
                //Time
                Text(scheduleDict["DINNER"]!)
                    .font(.system(size:12))
                    .foregroundColor(Color.timeForegroundColor)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 10)
                    .background(Color.timeBackgroundColor)
                    .cornerRadius(10)
            }

            //Contents
            VStack(alignment: .leading, spacing: 2){
                if DINNER_FOODS != nil{
                    ForEach(DINNER_FOODS!.indices, id: \.self){
                        foodIndex in
                        if foodIndex < 4 {
                            Text(DINNER_FOODS![foodIndex])
                                .font(.system(size: 14))
                                .foregroundColor(Color.foodForeground)
                        }
                        else if foodIndex == 4 {
                            Text(DINNER_FOODS![foodIndex] + (DINNER_FOODS!.count > 5 ? " 외 \(DINNER_FOODS!.count - 5)개" : ""))
                                .font(.system(size: 14))
                                .foregroundColor(Color.foodForeground)
                        }
                    }
                }
                else if DINNER_FOODS == nil {
                    Text("위젯 제거 후 다시 추가해주세요.")
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}
