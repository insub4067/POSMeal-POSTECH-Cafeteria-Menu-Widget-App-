//
//  ComplicationController.swift
//  posmealWatch WatchKit Extension
//
//  Created by Park Sungmin on 2022/06/28.
//

import ClockKit
import SwiftUI


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    private let network = Network.shared
    
    // MARK: - Complication Configuration

    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
            CLKComplicationDescriptor(identifier: "complication", displayName: "포스밀", supportedFamilies: [
                .graphicCircular,
                .graphicCorner,
                .modularLarge
            ])
            // Multiple complication support can be added here with more descriptors
        ]
        
        // Call the handler with the currently supported complication descriptors
        handler(descriptors)
    }
    
    func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
        // Do any necessary work to support these newly shared complication descriptors
    }

    // MARK: - Timeline Configuration
    
//    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
//        // Call the handler with the last entry date you can currently provide or nil if you can't support future timelines
//        handler(nil)
//    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        // Call the handler with your desired behavior when the device is locked
        handler(.showOnLockScreen)
    }

    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline 
        switch complication.family {
        case .modularLarge:
            let dateComponent = Calendar.current.dateComponents([.month, .day, .hour, .minute, .second], from: Date())
            var menu: [String] = []
            var restau_name = ""
            
            if 0 <= dateComponent.hour! && dateComponent.hour! < 9{
                menu = network.BREAKFAST_A
                restau_name = "조식"
            }
            else if 9 <= dateComponent.hour! && dateComponent.hour! < 14 {
                menu = network.LUNCH
                restau_name = "중식"
            }
            else if 14 <= dateComponent.hour! && dateComponent.hour! <= 23{
                menu = network.DINNER
                restau_name = "석식"
            }
            
            guard let template = makeTemplate(title: "\(dateComponent.month!)월 \(dateComponent.day!)일 \(restau_name)", body: "\(menu[0])\n\(menu[1]) 외 \(menu.count-2 == 0 ? "" : String(menu.count-2))", comlication: complication)
            else {
                handler(nil)
                return
            }
                  
            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            
            handler(entry)
        
        case .graphicCorner:
            handler(nil)
            
        case .graphicCircular:
            let template = makeTemplate(title: "포스밀", body: "", comlication: complication)
            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template!)
            handler(entry)
            
        default:
            handler(nil)
        }
        
    }
    
//    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
//        // Call the handler with the timeline entries after the given date
//        handler(nil)
//    }

    // MARK: - Sample Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        let text = "오늘 식단의 일부가 여기에 표시됩니다"
        let template = makeTemplate(title: "포스밀", body: text, comlication: complication)
        
        handler(template)
    }
}

extension ComplicationController {
    func makeTemplate(
        title: String,
        body: String,
        comlication: CLKComplication
    ) -> CLKComplicationTemplate? {
        switch comlication.family {
        case .graphicRectangular:
            return CLKComplicationTemplateGraphicRectangularLargeView(headerTextProvider: CLKTextProvider(format: title, []), content: ComplicationModularLargeView(text: body))
            
        case .modularLarge:
            return CLKComplicationTemplateModularLargeStandardBody(headerTextProvider: CLKTextProvider(format: title, []), body1TextProvider: CLKTextProvider(format: body, []))
            
        case .modularSmall:
            return CLKComplicationTemplateModularSmallSimpleText(textProvider: CLKTextProvider(format: title, []))
            
        default:
            return nil
        }
    }
}
