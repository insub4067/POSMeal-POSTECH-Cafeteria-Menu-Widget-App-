//
//  ComplicationController.swift
//  POSmealWatch WatchKit Extension
//
//  Created by Park Sungmin on 2022/08/06.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Complication Configuration
    
    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
            CLKComplicationDescriptor(identifier: "complication", displayName: "포스밀", supportedFamilies: [
                .circularSmall,
                .graphicCorner,
                .modularSmall,
                .graphicCircular
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
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        // Call the handler with the last entry date you can currently provide or nil if you can't support future timelines
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        // Call the handler with your desired behavior when the device is locked
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        
        switch complication.family {
            
        case .circularSmall:
            let img: UIImage? = UIImage(named: "포스밀_글자_40.png")
            
            if let img = img {
                handler(CLKComplicationTimelineEntry(date: Date(),
                                                     complicationTemplate: CLKComplicationTemplateCircularSmallSimpleImage(imageProvider: CLKImageProvider(onePieceImage: img))))
            } else {
                handler(CLKComplicationTimelineEntry(date: Date(),
                                                     complicationTemplate: CLKComplicationTemplateCircularSmallSimpleText(textProvider: CLKTextProvider(format: "POS"))))
            }
            return
            
        case .graphicCorner:
            let img: UIImage? = UIImage(named: "포스밀_글자_40.png")
           
            if let img = img {
                handler(CLKComplicationTimelineEntry(date: Date(),
                                                     complicationTemplate: CLKComplicationTemplateGraphicCornerCircularImage(imageProvider: CLKFullColorImageProvider(fullColorImage: img))))
            } else {
                handler(CLKComplicationTimelineEntry(date: Date(),
                                                     complicationTemplate: CLKComplicationTemplateGraphicCornerTextImage(textProvider: CLKTextProvider(format: "POSmeal"),
                                                                                                                         imageProvider: CLKFullColorImageProvider(fullColorImage: UIImage(systemName: "list.bullet")!))))
            }
            return
            
        case .modularSmall:
            let img: UIImage? = UIImage(named: "포스밀_글자_40.png")
            
            if let img = img {
                handler(CLKComplicationTimelineEntry(date: Date(),
                                                     complicationTemplate: CLKComplicationTemplateModularSmallSimpleImage(imageProvider: CLKImageProvider(onePieceImage: img))))
            } else {
                handler(CLKComplicationTimelineEntry(date: Date(),
                                                     complicationTemplate: CLKComplicationTemplateModularSmallStackText(line1TextProvider: CLKTextProvider(format: "POS"), line2TextProvider: CLKTextProvider(format: "meal"))))
            }
            return
            
        case .graphicCircular:
            let img: UIImage? = UIImage(named: "포스밀_글자_40.png")
            
            if let img = img {
                handler(CLKComplicationTimelineEntry(date: Date(),
                                                     complicationTemplate: CLKComplicationTemplateGraphicCircularImage(imageProvider: CLKFullColorImageProvider(fullColorImage: img))))
            } else {
                handler(CLKComplicationTimelineEntry(date: Date(),
                                                     complicationTemplate: CLKComplicationTemplateGraphicCircularStackText(line1TextProvider: CLKTextProvider(format: "POS"), line2TextProvider: CLKTextProvider(format: "meal"))))
            }
            return
            
        default:
            handler(nil)
            return
        }
    }
    
    //    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
    //        // Call the handler with the timeline entries after the given date
    //        handler(nil)
    //    }
    
    // MARK: - Sample Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        
        switch complication.family {
            
        case .circularSmall:
            let img: UIImage? = UIImage(named: "포스밀_글자_40.png")
            
            if let img = img {
                handler(CLKComplicationTemplateCircularSmallSimpleImage(imageProvider: CLKImageProvider(onePieceImage: img)))
            } else {
                handler(CLKComplicationTemplateCircularSmallSimpleText(textProvider: CLKTextProvider(format: "POS")))
            }
            return
            
        case .graphicCorner:
            
            let img: UIImage? = UIImage(named: "포스밀_글자_40.png")
           
            if let img = img {
                handler(CLKComplicationTemplateGraphicCornerCircularImage(imageProvider: CLKFullColorImageProvider(fullColorImage: img)))
            } else {
                handler(CLKComplicationTemplateGraphicCornerTextImage(textProvider: CLKTextProvider(format: "POSmeal"),
                                                                      imageProvider: CLKFullColorImageProvider(fullColorImage: UIImage(systemName: "list.bullet")!)))
            }
            return
            
        case .modularSmall:
            let img: UIImage? = UIImage(named: "포스밀_글자_40.png")
            
            if let img = img {
                handler(CLKComplicationTemplateModularSmallSimpleImage(imageProvider: CLKImageProvider(onePieceImage: img)))
            } else {
                handler(CLKComplicationTemplateModularSmallStackText(line1TextProvider: CLKTextProvider(format: "POS"), line2TextProvider: CLKTextProvider(format: "meal")))
            }
            return
            
        case .graphicCircular:
            let img: UIImage? = UIImage(named: "포스밀_글자_40.png")
            
            if let img = img {
                handler(CLKComplicationTemplateGraphicCircularImage(imageProvider: CLKFullColorImageProvider(fullColorImage: img)))
            } else {
                handler(CLKComplicationTemplateGraphicCircularStackText(line1TextProvider: CLKTextProvider(format: "POS"), line2TextProvider: CLKTextProvider(format: "meal")))
            }
            return
            
        default:
            handler(nil)
            return
        }
    }
}
