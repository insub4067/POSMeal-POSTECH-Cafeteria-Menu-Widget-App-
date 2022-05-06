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

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: date)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: date)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let entry = SimpleEntry(date: date)
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 4, to: Date())
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate!))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

//widgetCardView
struct widgetCardView: View{
    let CURRENTDATE: [String:String]?
    let scheduleDict: [String:String]
    let selectedMeal : String?
    @State var FOODS: [String]? = []
    
    var body: some View {
        
        let myDict = [
            "BREAKFAST_A" : "조식",
            "BREAKFAST_B" : "간단식",
            "LUNCH" : "중식",
            "DINNER" : "석식",
            "STAFF" : "위즈덤",
            "INTERNATIONAL" : "더 블루힐"
        ]
        
        VStack(alignment: .leading){
            //Title
            HStack{
                //Title
                if selectedMeal != nil {
                    Text("\(myDict[selectedMeal!]!)")
                        .bold()
                }
                else if selectedMeal == nil {
                    Text("에러")
                        .bold()
                }
                Spacer()
                //Time
                Text(scheduleDict[selectedMeal ?? "LUNCH"]!)
                    .font(.system(size:12))
                    .foregroundColor(Color(red: 105/255, green: 105/255, blue: 105/255))
                    .padding(.vertical, 3)
                    .padding(.horizontal, 10)
                    .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                    .cornerRadius(10)
            }
            //Contents
            VStack(alignment: .leading, spacing: 2){
                if FOODS != nil{
                    ForEach(FOODS!, id: \.self){
                        food in
                        Text(food)
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
        .background(Color.white)
        .onAppear{
            self.FOODS = []
            self.FOODS = UserDefaults(suiteName: "group.com.kim.widgetProject")!.stringArray(forKey: self.selectedMeal ?? "LUNCH") as [String]?
        }
    }
}

//Widget View
struct myWidgetEntryView : View {
    //Define
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry
    let CURRENTDATE = UserDefaults(suiteName: "group.com.kim.widgetProject")!.dictionary(forKey: "CURRENTDATE") as! [String:String]?
    let SELECTEDMEAL = UserDefaults(suiteName: "group.com.kim.widgetProject")!.string(forKey: "SELECTEDMEAL") as String?
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
        "STAFF" : "~ 13:00",
        "INTERNATIONAL" : "~ 13:30"
    ]
    
    @ViewBuilder
    var body: some View {
        
        switch family{
        case .systemSmall:
            widgetCardView(
                CURRENTDATE: CURRENTDATE,
                scheduleDict: scheduleDictSMALL,
                selectedMeal: SELECTEDMEAL
            )
        case .systemMedium:
            widgetCardView(
                CURRENTDATE: CURRENTDATE,
                scheduleDict: scheduleDictMEDIUM,
                selectedMeal: SELECTEDMEAL
            )
        default:
            widgetCardView(
                CURRENTDATE: CURRENTDATE,
                scheduleDict: scheduleDictMEDIUM,
                selectedMeal: SELECTEDMEAL
            )
        }
  
    }
    

}

@main
struct myWidget: Widget {
    let kind: String = "포스밀 위젯"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            myWidgetEntryView(entry: entry)
                .environment(\.colorScheme, .light)
        }
        .configurationDisplayName("포스밀 위젯")
        .description("설정된 식당에 대한 오늘의 메뉴를 보여줍니다.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
