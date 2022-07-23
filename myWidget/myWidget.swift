//
//  myWidget.swift
//  myWidget
//
//  Created by Kim Insub on 2022/05/04.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    let date = Date()

    //PlACEHOLDER
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: date)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: date)
        completion(entry)
    }

    //VIEW REFRESH
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let entry = SimpleEntry(date: date)
        //BYADDING = UNIT, VALUE = HOW LONG, TO = FROM WHEN
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: Date())
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate!))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

//widgetCardView
struct widgetCardView: View{
    //Define
    @Environment(\.colorScheme) var colorScheme
    @State var FOODS: [String]? = []
    let CURRENTDATE: [String:String]?
    let scheduleDict: [String:String]
    let selectedMeal: String?
    let mealNameDict: [String:String]
    
    var body: some View {

        VStack(alignment: .leading){
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
                Text(scheduleDict[selectedMeal ?? "LUNCH"]!)
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color.backgroundColor)
        .onAppear{
            self.FOODS = []
            self.FOODS = UserDefaults(suiteName: "group.com.kim.widgetProject")!.stringArray(forKey: self.selectedMeal ?? "LUNCH") as [String]?
        }
    }
}

struct widgetMediumCardView: View{
    @Environment(\.colorScheme) var colorScheme
    @State var LUNCH_FOODS: [String]? = []
    @State var DINNER_FOODS: [String]? = []
    let CURRENTDATE: [String:String]?
    let scheduleDict: [String:String]
    let mealNameDict: [String:String]
    
    var body: some View {

        HStack{
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
            .onAppear{
                self.LUNCH_FOODS = []
                self.LUNCH_FOODS = UserDefaults(suiteName: "group.com.kim.widgetProject")!.stringArray(forKey: "LUNCH") as [String]?
            }
            
            Divider()
                .padding(.vertical)
            
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
            .onAppear{
                self.DINNER_FOODS = []
                self.DINNER_FOODS = UserDefaults(suiteName: "group.com.kim.widgetProject")!.stringArray(forKey: "DINNER") as [String]?
            }
        }
        .background(Color.backgroundColor)

    }
}

struct widgetLargeCardView: View{
    @Environment(\.colorScheme) var colorScheme
    @State var LUNCH_FOODS: [String]? = []
    @State var DINNER_FOODS: [String]? = []
    let CURRENTDATE: [String:String]?
    let scheduleDict: [String:String]
    let mealNameDict: [String:String]
    
    var body: some View{

        VStack{
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
            .onAppear{
                self.LUNCH_FOODS = []
                self.LUNCH_FOODS = UserDefaults(suiteName: "group.com.kim.widgetProject")!.stringArray(forKey: "LUNCH") as [String]?
            }
            
            Divider()
                .padding(.horizontal)
                
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
            .onAppear{
                self.DINNER_FOODS = []
                self.DINNER_FOODS = UserDefaults(suiteName: "group.com.kim.widgetProject")!.stringArray(forKey: "DINNER") as [String]?
            }
        }
        .background(Color.backgroundColor)

    }
}

//Widget View
struct myWidgetEntryView : View {
    //Define
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry
    let CURRENTDATE = UserDefaults(suiteName: "group.com.kim.widgetProject")!.dictionary(forKey: "CURRENTDATE") as! [String:String]?
    var SELECTEDMEAL = UserDefaults(suiteName: "group.com.kim.widgetProject")!.string(forKey: "SELECTEDMEAL") as String?
    let currentHour = Calendar.current.component(.hour, from: Date())
    let scheduleDictMEDIUM = [
        "BREAKFAST_A" : "07:30 ~ 09:30",
        "BREAKFAST_B" : "07:30 ~ 09:30",
        "LUNCH" : "11:30 ~ 13:30",
        "DINNER" : "17:30 ~ 19:00",
        "STAFF" : "11:50 ~ 13:00",
        "INTERNATIONAL" : "11:30 ~ 13:30"
    ]
    let scheduleDictSMALL = [
        "BREAKFAST_A" : "~ 09:30",
        "BREAKFAST_B" : "~ 09:30",
        "LUNCH" : "~ 13:30",
        "DINNER" : "~ 19:00",
        "STAFF" : "13:00",
        "INTERNATIONAL" : "13:30"
    ]
    let mealNameDict = [
        "BREAKFAST_A" : "조식",
        "BREAKFAST_B" : "간단식",
        "LUNCH" : "중식",
        "DINNER" : "석식",
        "STAFF" : "위즈덤",
        "INTERNATIONAL" : "더 블루힐"
    ]
    
    @ViewBuilder
    var body: some View {
        
        let selectedMeal = SELECTEDMEAL == "ONTIME" ? returnMealOnTime() : SELECTEDMEAL
        
        switch family{
        case .systemSmall:
            widgetCardView(
                CURRENTDATE: CURRENTDATE,
                scheduleDict: scheduleDictSMALL,
                selectedMeal: selectedMeal,
                mealNameDict: mealNameDict
            )
        case .systemMedium:
            widgetMediumCardView(
                CURRENTDATE: CURRENTDATE,
                scheduleDict: scheduleDictSMALL,
                mealNameDict: mealNameDict
            )
        default:
            widgetLargeCardView(
                CURRENTDATE: CURRENTDATE,
                scheduleDict: scheduleDictMEDIUM,
                mealNameDict: mealNameDict
            )
        }
    }
    
    func returnMealOnTime() -> String{
        let currenHour = Calendar.current.component(.hour, from: Date())
        var result = ""
        
        if 0 <= currenHour && currenHour < 9{
            result = "BREAKFAST_A"
        }
        else if 9 <= currenHour && currenHour < 14 {
            result = "LUNCH"
        }
        else if 14 <= currenHour && currenHour <= 23{
            result = "DINNER"
        }
        return result
    }
}

@main
struct myWidget: Widget {
    let kind: String = "포스밀 위젯"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            myWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("포스밀 위젯")
        .description("설정된 식당에 대한 오늘의 메뉴를 보여줍니다.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
