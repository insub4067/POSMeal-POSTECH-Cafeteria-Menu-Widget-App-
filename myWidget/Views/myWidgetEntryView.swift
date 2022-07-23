//
//  myWidgetEntryView.swift
//  포스밀
//
//  Created by Kim Insub on 2022/07/23.
//

import SwiftUI
import WidgetKit

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
            widgetSmallCardView(
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
