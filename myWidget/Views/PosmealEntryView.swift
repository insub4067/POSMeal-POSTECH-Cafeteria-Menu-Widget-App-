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

    @ViewBuilder
    var body: some View {

        let selectedMeal = SELECTEDMEAL == "ONTIME" ? returnMealOnTime() : SELECTEDMEAL

        switch family{
        case .systemSmall:
            WidgetSmallCardView(
                selectedMeal: selectedMeal
            )
        case .systemMedium:
            WidgetMediumCardView()
        default:
            WidgetLargeCardView()
        }
    }
}

fileprivate func returnMealOnTime() -> String{
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
