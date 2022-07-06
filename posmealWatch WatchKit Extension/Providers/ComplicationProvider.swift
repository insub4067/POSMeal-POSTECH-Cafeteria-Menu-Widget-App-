//
//  ComplicationProvider.swift
//  posmealWatch WatchKit Extension
//
//  Created by Park Sungmin on 2022/06/30.
//

import Foundation
import ClockKit
import SwiftUI

final class ShortcutComplicationProvider {
    func getShortcutComplication() -> CLKComplicationTemplate {
        return CLKComplicationTemplateGraphicCornerCircularView(ComplicationShortcutView())
    }
}
