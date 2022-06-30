//
//  ComplicationView.swift
//  posmealWatch WatchKit Extension
//
//  Created by Park Sungmin on 2022/06/30.
//

import SwiftUI
import ClockKit
struct ComplicationModularLargeView: View {
    
    var text = ""
    
    var body: some View {
        Text(text)
            .font(.caption2)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ComplicationShortcutView: View {

    var body: some View {
        Image(systemName: "gamecontroller")
    }
}

struct ComplicationShortcutView_Preview: PreviewProvider {
    static var previews: some View {
        Group{
            ComplicationShortcutView()
            CLKComplicationTemplateGraphicCornerCircularView (
                ComplicationShortcutView()
            ).previewContext()
        }
    }
}
