//
//  ComplicationView.swift
//  posmealWatch WatchKit Extension
//
//  Created by Park Sungmin on 2022/06/30.
//

import SwiftUI
import ClockKit

struct ComplicationModularLargeView: View {
    let text: String
    
    var body: some View {
        VStack {
            Text(text)
                .font(.caption2)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ComplicationShortcutView: View {
    
    var body: some View {
        VStack{
            Image(systemName: "gamecontroller")
            Text("포스밀")
                .font(.caption2)
        }
    }
}

//struct ComplicationShortcutView_Preview: PreviewProvider {
//    static var previews: some View {
//        Group{
//            CLKComplicationTemplateModularLargeStandardBody (
//                ComplicationModularLargeView(viewModel: ComplicationModularLargeViewModel(title: "7월 7일 중식", menu0: "밥", menu1: "밥2"))
//            ).previewContext()
//        }
//    }
//}
