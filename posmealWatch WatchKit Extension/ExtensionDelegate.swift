//
//  ExtensionDelegate.swift
//  posmealWatch WatchKit Extension
//
//  Created by Park Sungmin on 2022/06/30.
//

import WatchKit
import ClockKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    
    func applicationDidFinishLaunching() {
        scheduleNextReload()
        reloadActiveComplications()
    }
    
    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        for task in backgroundTasks {
            switch task {
            case let task as WKApplicationRefreshBackgroundTask:
//                task.setTaskCompletedWithSnapshot($0)
                scheduleNextReload()
                
            default:
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }
    
    private func reloadActiveComplications() {
        let server = CLKComplicationServer.sharedInstance()
        for complication in server.activeComplications ?? [] {
            server.reloadTimeline(for: complication)
        }
    }
    
    // 1시간을 타겟 시간으로 잡고
    // 백그라운드를 1시간마다 리프레시하기
    private func scheduleNextReload() {
        let targetDate = Date().addingTimeInterval(60 * 60)
        WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: targetDate,
                                                       userInfo: nil) { _ in }
    }
}

