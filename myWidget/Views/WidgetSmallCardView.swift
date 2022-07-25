//
//  SwiftUIView.swift
//  포스밀
//
//  Created by Kim Insub on 2022/07/23.
//

import SwiftUI
import WidgetKit

struct WidgetSmallCardView: View{

    //Define
    @State var FOODS: [String]? = []

    let selectedMeal: String?

    let scheduleDict = TimeManager().schedule
    let mealNameDict = TimeManager().mealNameDict

    var body: some View {

        VStack(alignment: .leading){
            menuViewBuilder()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color.cardBackground)
        .onAppear{
            self.FOODS = []
            self.FOODS = UserDefaults(suiteName: "group.com.kim.widgetProject")?.stringArray(forKey: self.selectedMeal ?? "LUNCH") as? [String]
        }
    }

    @ViewBuilder func menuViewBuilder() -> some View {
        //Title
        HStack{
            //Title
            Group{
                if selectedMeal != nil {
                    Text("\(mealNameDict[selectedMeal!]!)")
                        .bold()
                }
                else if selectedMeal == nil {
                    Text("에러")
                        .bold()
                }
            }
            Spacer()
            //Time
            Text((scheduleDict[selectedMeal ?? "LUNCH"]!))
                .font(.system(size:12))
                .foregroundColor(Color.timeForegroundColor)
                .padding(.vertical, 3)
                .padding(.horizontal, 10)
                .background(Color.timeBackgroundColor)
                .cornerRadius(10)
        }
        //Contents
        VStack(alignment: .leading, spacing: 2){
            if FOODS != nil{
                ForEach(FOODS!.indices, id: \.self){
                    foodIndex in
                    if foodIndex < 4 {
                        Text(FOODS![foodIndex])
                            .font(.system(size: 14))
                            .foregroundColor(Color.foodForeground)
                    }
                    else if foodIndex == 4 {
                        Text(FOODS![foodIndex] + (FOODS!.count > 5 ? " 외 \(FOODS!.count - 5)개" : ""))
                            .font(.system(size: 14))
                            .foregroundColor(Color.foodForeground)
                    }
                }
            }
            else if FOODS == nil {
                Text("위젯 제거 후 다시 추가해주세요.")
            }
            Spacer()
        }
    }
}
