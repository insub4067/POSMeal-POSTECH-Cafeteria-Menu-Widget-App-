//
//  myWidget.swift
//  myWidget
//
//  Created by Kim Insub on 2022/05/04.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {

    @EnvironmentObject var network: Network
    
    let date = Date()

    //PlACEHOLDER
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: date)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {

        network.getMenus(of: "today")

        let entry = SimpleEntry(date: date)
        completion(entry)
    }

    //VIEW REFRESH
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {

        let entry = SimpleEntry(date: date)

        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: Date())
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate!))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

@main
struct myWidget: Widget {

    let kind: String = "com.kim.widgetProject.myWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            myWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("포스밀 위젯")
        .description("설정된 식당에 대한 오늘의 메뉴를 보여줍니다.")
        .supportedFamilies(
            [
                .systemSmall,
                .systemMedium,
                .systemLarge,
            ]
        )
    }
}
